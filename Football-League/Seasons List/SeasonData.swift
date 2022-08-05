//
//  SeasonModel.swift
//  Football-League
//
//  Created by Nodir on 05/08/22.
//

import Foundation

struct SeasonsModel: Codable {
    var status: Bool
    var data: SeasonsData
}

struct SeasonsData: Codable {
    var name: String
    var desc: String
    var abbreviation: String
    var seasons: [Seasons]
}

struct Seasons: Codable {
    var year: Int
    var startDate: String
    var endDate: String
    var displayName: String
    var types: [Types]
}

struct Types: Codable {
    var id: String
    var name: String
    var abbreviation: String
    var startDate: String
    var endDate: String
    var hasStandings: Bool
}
