//
//  IslandUseCase.swift
//  OkinawaApp
//
//  Created by nancy on 2019/10/27.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

enum FetchError: Error {
    case notFoundSuchFile
}

final class IslandUseCase {

    func fetchIslands() -> Single<IslandResponse> {
        return Single<IslandResponse>.create(subscribe: { observer in
            do {
                let fileName = "island"
                guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
                    observer(.error(FetchError.notFoundSuchFile))
                    return Disposables.create()
                }
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                let json = JSON(data)
                observer(.success(IslandResponse(json)))
            } catch {
                observer(.error(FetchError.notFoundSuchFile))
            }
            return Disposables.create()
        })
    }
}
