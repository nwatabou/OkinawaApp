//
//  IslandsListViewModel.swift
//  OkinawaApp
//
//  Created by nancy on 2020/02/22.
//  Copyright © 2020 nwatabou. All rights reserved.
//

import Foundation
import RxSwift

final class IslandsListViewModel {

    private let useCase = IslandUseCase()

    func fetchIslands() -> Single<[Island]> {
        return useCase.fetchIslands().flatMap({ (response: Islands) -> Single<[Island]> in
            return Single.just(response.islands)
        })
    }
}
