//
//  TokenError.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

enum TokenError: Error {
    case saving
    case storedToken
    case notFound
    case expired
    case configurationMissing
}
