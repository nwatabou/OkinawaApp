//
//  MapViewModel.swift
//  OkinawaApp
//
//  Created by nancy on 2019/10/27.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import Foundation
import RxSwift

final class MapViewModel {

    private let useCase = IslandUseCase()

    func fetchIslands() -> Single<[Island]> {
        return useCase.fetchIslands().flatMap({ (response: IslandResponse) -> Single<[Island]> in
            return Single.just(response.islands)
        })
    }
}
