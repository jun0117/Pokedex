//
//  APIManager.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import Moya
import SwiftyJSON
import RxSwift

struct APIManger {

    private let provider = MoyaProvider<APIService>()

    func fetch(_ api: APIService) -> Observable<JSON> {
        provider.rx.request(api)
            .map { JSON($0.data) }
            .retry(3)
            .asObservable()
    }
}
