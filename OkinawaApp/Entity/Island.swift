//
//  Island.swift
//  OkinawaApp
//
//  Created by nancy on 2019/10/26.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import Foundation

struct Island: Codable {
    let id: String
    let name: String
    let nameKana: String
    let urlString: String
    let latitude: Float
    let longitude: Float
    var isVisited: Bool
    
    init(id: String, name: String, nameKana: String, urlString: String, latitude: Float, longitude: Float, isVisited: Bool) {
        self.id = id
        self.name = name
        self.nameKana = nameKana
        self.urlString = urlString
        self.latitude = latitude
        self.longitude = longitude
        self.isVisited = isVisited
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case nameKana = "name_kana"
        case urlString = "uri"
        case latitude
        case longitude
        case isVisited = "is_visited"
    }
}
