//
//  SurveyViewModel.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

@MainActor
final class SurveyViewModel: ObservableObject {
    
    @Published var surveys: [SurveyDto] = []
    @Published var viewState: ViewState = .loading
    
    init() {
        
        Task {
            let repository = SurveyRepositoryImplementation()
            
            surveys = try await repository.fetchSurveys()
            viewState = .loaded
            
        }
    }
}
