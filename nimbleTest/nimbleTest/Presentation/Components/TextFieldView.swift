//
//  TextFieldView.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 2/11/23.
//

import SwiftUI

struct TextFieldView: View {
    @FocusState private var textFocus
    @Binding var text: String
    var placeholder: String
    
    var textColor = Color.white.opacity(0.3)
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .focused($textFocus)
                .foregroundStyle(textColor)
                .padding(.horizontal, 12)
            
            if text.isBlank && !self.textFocus {
                Text(placeholder)
                    .foregroundStyle(textColor)
                    .padding(.horizontal, 12)
            }
            
        }
        .frame(height: 56)
        .roundedBackground(Color.white.opacity(0.18))
        .contentShape(Rectangle())
        .onTapGesture {
            textFocus = true
        }
    }
}

#Preview {
    
    @State var inputText = ""
    
    return ZStack {
        Color.gray.opacity(30)
        
        TextFieldView(text: $inputText, placeholder: "Enter Text")
    }
}
