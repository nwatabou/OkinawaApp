//
//  NSObject+Extension.swift
//  OkinawaApp
//
//  Created by nancy on 2020/02/22.
//  Copyright © 2020 nwatabou. All rights reserved.
//

import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
