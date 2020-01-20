//
//  Sample.swift
//  FishMasterSDK
//
//  Created by Yatseyko Yuriy on 1/20/20.
//

import Foundation

struct Sample: Codable {
    
    enum CodingKeys: String, CodingKey {
        case unitId = "unit_id"
        case unitTitle = "unit_title"
        case unitType = "unit_type"
        case actionLink = "action_link"
        case data = "data"
    }
    
    var unitId: String
    var unitTitle: String
    var unitType: String
    var actionLink: String
    var data: SampleData
}

struct SampleData: Codable {
    
    enum CodingKeys: String, CodingKey {
        case logoUrl = "logo_url"
        case titleCopy = "title_copy"
        case heroCopy = "hero_copy"
        case secondLine = "2nd_line"
        case bodyCopy = "body_copy"
        case bgColor = "bg_color"
        case font = "font"
    }
    
    var logoUrl: String
    var titleCopy: String
    var heroCopy: String
    var secondLine: String
    var bodyCopy: String
    var bgColor: String
    var font: SampleDataFont
}

struct SampleDataFont: Codable {
    
    enum CodingKeys: String, CodingKey {
        case size = "size"
        case color = "color"
        case family = "family"
    }
    
    var size: Int
    var color: String
    var family: String
}
