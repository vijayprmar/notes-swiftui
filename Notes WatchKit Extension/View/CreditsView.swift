//
//  CreditsView.swift
//  Notes WatchKit Extension
//
//  Created by Vijay Parmar on 12/12/22.
//

import SwiftUI

struct CreditsView: View {
    //MARK:-  PROPERTY
    @State private var randNumber:Int = Int.random(in: 1..<4)
    
    
    private var randomImage:String{
        return "developer-no\(randNumber)"
    }
    
    
    //MARK:- BODY
    var body: some View {
        VStack(spacing: 3) {
            //PROFILE NAME
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            //HEADER
            HeaderView(title: "Credits")
            //CONTENT
            Text("Vijay Parmar")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            Text("iOS Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
        }//:VSTACK
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
