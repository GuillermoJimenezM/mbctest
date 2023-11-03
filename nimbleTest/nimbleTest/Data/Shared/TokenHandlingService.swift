//
//  TokenHandlingService.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

final class TokenHandlingService {

    static var shared = TokenHandlingService()

    func saveToken(bearerToken: String) {

        if bearerToken.isEmpty {
            return
        }

        let tokenModel = TokenModel(token: bearerToken)

        KeyChainService.shared.save(tokenModel,
                                    service: CurrentEnvironment.shared.bundleAppIdentifier,
                                    account: "keyChainToken")
    }

    func getToken() throws -> String {

        guard let tokenModel = KeyChainService.shared.read(service: CurrentEnvironment.shared.bundleAppIdentifier,
                                                            account: "keyChainToken",
                                                            type: TokenModel.self) else {
            throw TokenError.notFound
        }
        
#if DEBUG
        print("TOKEN:", tokenModel.token)
#endif

        return tokenModel.token
    }

    func deleteToken() throws {

        KeyChainService.shared.delete(service: CurrentEnvironment.shared.bundleAppIdentifier,
                                      account: "keyChainToken")
    }
}
