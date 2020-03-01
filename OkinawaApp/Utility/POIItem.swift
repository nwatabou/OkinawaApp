//
//  POIItem.swift
//  OkinawaApp
//
//  Created by nancy on 2020/03/01.
//  Copyright © 2020 nwatabou. All rights reserved.
//

import Foundation
import GoogleMapsUtils

class POIItem: NSObject, GMUClusterItem {

    var position: CLLocationCoordinate2D
    var name: String

    init(position: CLLocationCoordinate2D, name: String) {
        self.position = position
        self.name = name
    }
}
