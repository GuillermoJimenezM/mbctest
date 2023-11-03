//
//  nimbleTestApp.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 2/11/23.
//

import SwiftUI

@main
struct nimbleTestApp: App {
    
    @ObservedObject var viewRouter = RouterViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewRouter)
        }
    }
}
