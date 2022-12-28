//
//  HeaderView.swift
//  Notes WatchKit Extension
//
//  Created by Vijay Parmar on 12/12/22.
//

import SwiftUI

struct HeaderView: View {
    //MARK:- PROPERTY
    
    var title : String = ""
    
    var body: some View {
        VStack {
            //Title
            if title != ""{
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
            }
            
            //Seperator
            HStack{
                Capsule()
                    .frame(height:1)
                Image(systemName: "note.text")
                Capsule()
                    .frame(height:1)
            }//:Hstack
            .foregroundColor(.accentColor)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(title: "Credits")
            HeaderView()
        }
    }
}
