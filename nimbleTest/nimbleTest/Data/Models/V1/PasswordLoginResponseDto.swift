//
//  PasswordLoginResponseDto.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

struct PasswordLoginResponseDto: Codable {
    let data: PasswordLoginResponseBodyDto
}

struct PasswordLoginResponseBodyDto: Codable {
    let id: String
    let type: String
    let attributes: AttributeDto
}

struct AttributeDto: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String
    let createdAt: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
    }
}
