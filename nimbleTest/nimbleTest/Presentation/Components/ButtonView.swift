//
//  ButtonView.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import SwiftUI

struct ButtonView: View {
    var label: String
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            Text(label)
                .foregroundStyle(.black)
                .bold()
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .roundedBackground(.white)
        }
        .buttonStyle(.plain)
    }
    
}

#Preview {
    ZStack {
        Color.gray
        
        ButtonView(label: "button") {
            print("button click")
        }
    }
   
}
