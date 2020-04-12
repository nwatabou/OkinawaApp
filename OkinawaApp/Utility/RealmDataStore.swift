//
//  RealmDataStore.swift
//  OkinawaApp
//
//  Created by Wataru Nakanishi on 2020/04/12.
//  Copyright © 2020 nwatabou. All rights reserved.
//

import RxSwift
import RealmSwift

final class RealmDataStore {
    
    private let realm: Realm?
    
    init() {
        do {
            self.realm = try Realm()
        } catch {
            self.realm = nil
        }
    }
    
    func loadAll<T: Object>() -> Single<Results<T>> {
        return Single.create(subscribe: { [weak self] observer in
            guard let objects = self?.realm?.objects(T.self) else {
                observer(.error(RealmError.fail))
                return Disposables.create()
            }
            observer(.success(objects))
            return Disposables.create()
        })
    }
    
    func write<T: Object>(data: T) {
        realm?.add(data, update: .modified)
    }
}
