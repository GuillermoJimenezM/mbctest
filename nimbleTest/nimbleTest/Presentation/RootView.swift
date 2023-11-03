//
//  RootView.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 2/11/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        
        ZStack {
            
            
            Image("background")
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(minWidth: 0, maxWidth: .infinity)
                          .edgesIgnoringSafeArea(.all)
                //.scaledToFill()
               
        }
        ///.edgesIgnoringSafeArea(.all)
       //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    RootView()
}
