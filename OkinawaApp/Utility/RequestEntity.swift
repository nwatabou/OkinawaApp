//
//  RequestEntity.swift
//  OkinawaApp
//
//  Created by nancy on 2019/10/26.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import Foundation

protocol RequestEntity {
    func parameterize() -> [String: Any]
}
