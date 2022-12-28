//
//  DetailView.swift
//  Notes WatchKit Extension
//
//  Created by Vijay Parmar on 12/12/22.
//

import SwiftUI

struct DetailView: View {
    //MARK: - Property
    
    let note :Note
    let count :Int
    let index :Int
    
    @State private var isCreditsPresented :Bool = false
    @State private var isSettingPresented :Bool = false
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            //HEADER
          HeaderView(title: "")
            
            //CONTENT
            Spacer()
            ScrollView(.vertical){
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            //FOOTER
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingPresented, content: {
                        SettingsView()
                    })
                Spacer()
                Text("\(count) / \(index+1)")
                Spacer()
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditsPresented.toggle()
                    }
                    .sheet(isPresented:$isCreditsPresented,content: {
                        CreditsView()
                    })
            }//:HSTACK
            .foregroundColor(.secondary)
        }//:STACK
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var sampleData:Note = Note(id: UUID(), text: "Hello World")
    static var previews: some View {
        DetailView(note: sampleData, count: 5, index: 1)
    }
}
