//
//  LogInView.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import SwiftUI

struct LogInView: View {
    
    @State private var emailText = ""
    @State private var passwordText = ""
    
    var body: some View {
        
        ZStack {
            
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .blur(radius: 30)
                .edgesIgnoringSafeArea(.all)
            
            LinearGradient(colors: [.black.opacity(0.2), .black], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Image("logoWhite")
                    .padding(.vertical, 120)
                
                VStack(spacing: 20) {
                    TextFieldView(text: $emailText, placeholder: "email".fromLocale())
                    
                    PasswordTextFieldView(text: $passwordText, placeholder: "password".fromLocale()) {
                    }
                    
                    ButtonView(label: "login".fromLocale()) {
                        
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LogInView()
}
