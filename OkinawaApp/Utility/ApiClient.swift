//
//  ApiClient.swift
//  OkinawaApp
//
//  Created by nancy on 2019/10/26.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RxSwift

protocol ApiClientProtocol {
    var baseUrl: String { get }
    init(baseUrl: String)
    func get<T: ResponseEntity>(path: String?, request: RequestEntity?) -> Single<T>
    func post<T: ResponseEntity>(path: String?, request: RequestEntity?) -> Single<T>
}

class ApiClient: ApiClientProtocol {

    let baseUrl: String

    required init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func get<T: ResponseEntity>(path: String?, request: RequestEntity?) -> Single<T> {

        var requestUrl = baseUrl
        if let path = path {
            requestUrl = baseUrl + path
        }

        var params = Parameters()
        if let request = request {
            params = request.parameterize()
        }

        return Single<T>.create { single in
            let session = Session.default
            let request = session.request(requestUrl,
                                          method: .get,
                                          parameters: params,
                                          encoding: URLEncoding.default,
                                          headers: nil)
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(_):
                        guard let data = response.data else {
                            return single(.error(response.error!))
                        }
                        let json = JSON(data)
                        return single(.success(T(json)))
                        
                    case .failure(let error):
                        return single(.error(error))
                    }
                })
            return Disposables.create {
                return request.cancel()
            }
        }
    }

    func post<T: ResponseEntity>(path: String?, request: RequestEntity?) -> Single<T> {
        var requestUrl = baseUrl
        if let path = path {
            requestUrl = baseUrl + path
        }
        
        var params = Parameters()
        if let request = request {
            params = request.parameterize()
        }
        
        return Single<T>.create { single in
            let session = Session.default
            let request = session.request(requestUrl,
                                          method: .get,
                                          parameters: params,
                                          encoding: URLEncoding.default,
                                          headers: nil)
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(_):
                        guard let data = response.data else {
                            return single(.error(response.error!))
                        }
                        let json = JSON(data)
                        return single(.success(T(json)))
                        
                    case .failure(let error):
                        return single(.error(error))
                    }
                })
            return Disposables.create {
                return request.cancel()
            }
        }
    }
}
