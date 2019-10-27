//
//  ResponseEntity.swift
//  OkinawaApp
//
//  Created by nancy on 2019/10/26.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ResponseEntity {
    var json: JSON { get }
    init(_ json: JSON)
}
