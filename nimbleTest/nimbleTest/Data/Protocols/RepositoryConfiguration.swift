//
//  RepositoryConfiguration.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

protocol RepositoryConfiguration {
    var route: String { get set }
}

extension RepositoryConfiguration {

    func buildUrl() -> String {
        return "\(CurrentEnvironment.shared.endpointUrl)/v1/\(route)"
    }

    func getHeaders() -> [String: String] {
        let headers: [String: String] = [
            "content-Type": "application/json"
        ]

        return headers
    }

    func getAuthHeaders() throws -> [String: String] {
        do {
        let headers: [String: String] = try [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(TokenHandlingService.shared.getToken())"
        ]
            return headers
        } catch {
            print("error")
            throw error
        }
    }
}
