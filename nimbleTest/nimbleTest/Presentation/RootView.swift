//
//  RootView.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 2/11/23.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var viewRouter: RouterViewModel
    
    var body: some View {
        
        switch viewRouter.viewMode {
        case .login:
            LogInView()
        case .home:
            SurverListView()
        }
    }
}

#Preview {
    RootView()
}
