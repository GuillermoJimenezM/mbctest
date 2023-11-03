//
//  AuthRepository.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 2/11/23.
//

import Foundation

protocol AuthRepository {
    func loginUser(email: String, password: String)
}
