//
//  SurveyDto.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

struct SurveyListDto: Codable {
    let data: [SurveyDto]
}

struct SurveyDto: Codable, Identifiable {
    let id: String
    let type: String
    var attributes: SurveyDataDto

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case attributes = "attributes"
    }
}


struct SurveyDataDto: Codable {
    let title: String
    let description: String
    let thankEmailAboveThreshold: String?
    let thankEmailBelowThreshold: String?
    let isActive: Bool
    let coverImageURL: String
    let createdAt: String
    let activeAt: String
    let inactiveAt: String?
    let surveyType: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case thankEmailAboveThreshold = "thank_email_above_threshold"
        case thankEmailBelowThreshold = "thank_email_below_threshold"
        case isActive = "is_active"
        case coverImageURL = "cover_image_url"
        case createdAt = "created_at"
        case activeAt = "active_at"
        case inactiveAt = "inactive_at"
        case surveyType = "survey_type"
    }
}
