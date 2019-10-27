//
//  IslandsResponse.swift
//  OkinawaApp
//
//  Created by nancy on 2019/10/26.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import Foundation
import SwiftyJSON

struct IslandResponse: ResponseEntity {
    
    let islands: [Island]
    
    init(_ json: JSON) {
        let array = json["response"]["list"].arrayValue
        self.islands = array.map({ data -> Island in
            return Island(id: data["id"].stringValue,
                          name: data["name"].stringValue,
                          nameKana: data["nameKana"].stringValue,
                          uri: URL(string: data["uri"].stringValue),
                          latitude: data["latitude"].floatValue,
                          longitude: data["longitude"].floatValue)
        })
    }
}