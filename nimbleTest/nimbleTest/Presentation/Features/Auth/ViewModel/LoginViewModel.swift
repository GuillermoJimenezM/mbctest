//
//  LoginVIewModel.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
 
    func loginWithPassword(email: String, password: String) {
        
        if email.isBlank || password.isBlank {
            return
        }
        
        let repository = AuthRepositoryImplementation()
        
        Task {
            try await repository.loginUser(email: email, password: password)
            RouterViewModel.shared.viewMode = .home
        }
    }
}
