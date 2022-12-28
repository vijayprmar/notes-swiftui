//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy 
//

import SwiftUI

struct ContentView: View {
  // MARK: - PROPERTY
    @AppStorage("lineCount") var lineCount:Int = 1
    @State private var notes : [Note] = [Note]()
    @State private var text : String = ""
    //MARK: - Function
    
    func getDocumentDirectory()->URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save(){
     // dump(notes)
        
        do{
            
            //1. Convert the notes array to data using JSONEncoder
            let data = try JSONEncoder().encode(notes)
            
            //2. Create a new URL to save the file using the getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            //3. Write the data to given URL
            try data.write(to: url)
            
        }catch{
            print("Saving data failed")
        }
     
    }
    
    func load(){
        
        DispatchQueue.main.async {
            do {
            //1. get the notes url path
                let url = getDocumentDirectory().appendingPathComponent("notes")
            //2. create a new property for the data
                let data = try Data(contentsOf: url)
            //3. decode data
                notes = try JSONDecoder().decode([Note].self, from: data)
            }catch{
                //Do Nothing
            }
        }
    }
    
    func delete(offset:IndexSet){
        withAnimation {
            notes.remove(atOffsets: offset)
            save()
        }
    }
    
 //MARK: - Body
  var body: some View {
    
      VStack{
          HStack(alignment:.center,spacing: 6){
              TextField("Add New Note", text: $text)
              Button{
                  //1.only run the button's action when the text field is not empty
                  guard text.isEmpty == false else {return}
                  //2.create a new note iem and initialze it with the text value
                  let note = Note(id: UUID(), text: text)
                  //3.add the new note item to the notes array (append)
                  notes.append(note)
                  //4.make the text field empty
                  text = ""
                  //5.save the notes (function)
                  save()
              }label: {
                  Image(systemName: "plus.circle")
                      .font(.system(size: 42,weight: .semibold))
              }
              .fixedSize()
              .buttonStyle(PlainButtonStyle())
              .foregroundColor(.accentColor)
          }//Hstack
          Spacer()
          
          
          if notes.count >= 1 {
              List{
                  ForEach(0..<notes.count,id:\.self) { i in
                      NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                          HStack{
                              Capsule()
                                  .frame(width:4)
                                  .foregroundColor(.accentColor)
                              Text(notes[i].text)
                                  .lineLimit(lineCount)
                                  .padding(.leading,5)
                          }
                      }
                  }.onDelete(perform: delete)
              }
          } else {
              Spacer()
              Image(systemName: "note.text")
                  .resizable()
                  .scaledToFit()
                  .foregroundColor(.gray)
                  .opacity(0.25)
                  .padding(20)
              
              
              Spacer()
          }
      }//Vstack
      .navigationTitle("Notes")
      .onAppear(perform: {
          load()
      })
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
