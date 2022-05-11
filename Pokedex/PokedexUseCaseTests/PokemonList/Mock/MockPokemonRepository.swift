//
//  MockPokemonRepository.swift
//  Pokedex
//
//  Created by 이준성 on 2022/05/11.
//

import RxSwift
import Moya

final class MockPokemonRepository: PokemonRepository {
    private let apiManager: APIManager

    init() {
        let endpointClosure = { (target: APIService) -> Endpoint in
            Endpoint(url: URL(target: target).absoluteString,
                     sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                     method: target.method,
                     task: target.task,
                     httpHeaderFields: target.headers)
        }
        let provider = MoyaProvider<APIService>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        self.apiManager = APIManager(provider: provider)
    }

    func fetchPokemonList(page: Int) -> Observable<[Pokemon]> {
        apiManager
            .fetch(.pokemonList(page))
            .map {
                $0["results"].arrayValue.map {
                    Pokemon.fromJSON($0, page: page)
                }
            }
    }

    func fetchPokemonInfo(index: Int) -> Observable<PokemonInfo> {
        .just(.init())
    }
}
