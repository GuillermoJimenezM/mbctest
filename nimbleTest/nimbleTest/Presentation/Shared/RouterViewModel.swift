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
    @Published var viewMode: RouterViewMode
    
    public static let shared = RouterViewModel()
    
    private init() {
        
        do {
            let _ = try TokenHandlingService.shared.getToken()
            viewMode = .home
        } catch {
            viewMode = .login
        }
    }
}
