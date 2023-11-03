//
//  PasswordLoginModel.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

struct PasswordLoginDto: Codable {
    let grantType: String
    let email: String
    let password: String
    let clientID: String
    let clientSecret: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
        grantType = "password"
        clientID = CurrentEnvironment.shared.apiClientId
        clientSecret = CurrentEnvironment.shared.apiSecretKey
    }

    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case email = "email"
        case password = "password"
        case clientID = "client_id"
        case clientSecret = "client_secret"
    }
}
