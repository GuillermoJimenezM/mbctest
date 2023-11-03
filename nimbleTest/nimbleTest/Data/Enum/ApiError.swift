//
//  ApiError.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 2/11/23.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case tempError  // TODO: add an error response model
    case errorDeleting
    case fatal(message: String)
    case notFound
    case invalidServerResponse
    case notValidToken
}
