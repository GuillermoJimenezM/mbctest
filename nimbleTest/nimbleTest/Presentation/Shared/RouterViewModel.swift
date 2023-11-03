//
//  RouterViewModel.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation
import SwiftUI

@MainActor
final class RouterViewModel: ObservableObject {
    @Published var viewMode: RouterViewMode = .login
    
    public static let shared = RouterViewModel()
    
    private init() {
        
        do {
            let _ = try TokenHandlingService.shared.getToken()
            viewMode = .home
        } catch {
            viewMode = .login
        }
    }
    
    func logout() {
        do {
            try TokenHandlingService.shared.deleteToken()
            viewMode = .login
        } catch {
          
        }
    }
}
