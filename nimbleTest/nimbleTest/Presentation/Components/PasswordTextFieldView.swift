//
//  PasswordTextFieldView.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import SwiftUI

struct PasswordTextFieldView: View {
    @FocusState private var textFocus
    @Binding var text: String
    var placeholder: String
    var forgotAction: () -> Void
    
    var textColor = Color.white.opacity(0.3)
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            HStack {
                SecureField("", text: $text)
                    .focused($textFocus)
                    .foregroundStyle(textColor)
            
                Spacer()
                
                Text("forgot")
                    .foregroundStyle(textColor)
                    .onTapGesture(perform: forgotAction)
                
            }
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
        
        PasswordTextFieldView(text: $inputText, placeholder: "Enter Text") { print("its working")}
    }
}
