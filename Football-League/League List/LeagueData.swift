//
//  LeagueModel.swift
//  Football-League
//
//  Created by Nodir on 04/08/22.
//

import Foundation

struct LeagueModel: Codable {
    var status: Bool
    var data: [LeagueData]
}

struct LeagueData: Codable {
    var  id: String
    var name: String
    var slug: String
    var abbr: String
    var logos: Logos
}

struct Logos: Codable {
    var light: String
    var dark: String
}
