//
//  Islands.swift
//  OkinawaApp
//
//  Created by nancy on 2019/10/26.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import Foundation

struct Islands: Codable {
    
    let islands: [Island]
    
    init(islands: [Island]) {
        self.islands = islands
    }
    
    enum CodingKeys: String, CodingKey {
        case islands = "response"
    }
}
