//
//  StandingModel.swift
//  Football-League
//
//  Created by Nodir on 05/08/22.
//

import Foundation


struct StandingModel: Codable {
    var status: Bool
    var data: StandingData
}

struct StandingData: Codable {
    var name: String
    var abbreviation: String
    var seasonDisplay: String
    var season: Int
    var standings: [Standings]
}

struct Standings: Codable {
    var team: Team
    var stats: [Stats]
}

struct Team: Codable {
    var displayName: String
    var abbreviation: String
    var logos: [Logo]
}

struct Stats: Codable {
    var displayName: String
    var displayValue: String
}

struct Logo: Codable {
    var href: String
}
