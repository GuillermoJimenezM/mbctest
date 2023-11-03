//
//  Authentication.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

public class AuthRepositoryImplementation: RepositoryConfiguration, AuthRepository {
   
    var route = "oauth/token"
    
    func loginUser(email: String, password: String) async throws {
        
        let loginDto = PasswordLoginDto(email: email, password: password)

        let result: PasswordLoginResponseDto = try await NetworkClient.shared.post(endpoint: buildUrl(), headers: getHeaders(), requestBody: loginDto)
        
        if result.data.attributes.tokenType == "Bearer" {
            TokenHandlingService.shared.saveToken(bearerToken: result.data.attributes.accessToken)
        }
    }
}
