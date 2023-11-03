//
//  SurveyRepository.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

protocol SurveyRepository {
    func fetchSurveys() async throws -> [SurveyDto]
}
