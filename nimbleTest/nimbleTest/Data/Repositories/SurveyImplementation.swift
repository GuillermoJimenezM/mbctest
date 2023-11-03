//
//  SurveyImplementation.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

public class SurveyRepositoryImplementation: RepositoryConfiguration, SurveyRepository {
 
    var route = "surveys"
    
    func fetchSurveys() async throws -> [SurveyDto] {
        
        let result: SurveyListDto = try await NetworkClient.shared.get(endpoint: buildUrl(), headers: getAuthHeaders())
        
        return result.data
    }
}
