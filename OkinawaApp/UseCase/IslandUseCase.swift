//
//  IslandUseCase.swift
//  OkinawaApp
//
//  Created by nancy on 2019/10/27.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import Foundation
import RxSwift

enum FetchError: Error {
    case notFoundSuchFile
}

final class IslandUseCase {

    func fetchIslands() -> Single<Islands> {
        return Single<Islands>.create(subscribe: { observer in
            do {
                let fileName = "island"
                guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
                    observer(.error(FetchError.notFoundSuchFile))
                    return Disposables.create()
                }
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                let entity = try JSONDecoder().decode(Islands.self, from: data)
                observer(.success(entity))
            } catch {
                observer(.error(FetchError.notFoundSuchFile))
            }
            return Disposables.create()
        })
    }
}
