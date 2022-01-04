//
//  PokemonListRepository.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/05.
//

import RxSwift

class PokemonListRepository {
    private let apiManager = APIManger()
    private let dbManager = DBManager.shared

    func fetchPokemonList(page: Int) -> Observable<[Pokemon]> {
        let pokemonList = dbManager.getPokemonList(page)
        if pokemonList.isEmpty {
            return apiManager.fetch(.pokemonList(page))
                .map { $0["results"].arrayValue }
                .withUnretained(self)
                .do(onNext: { owner, jsonList in
                    owner.dbManager.insertPokemonList(page, jsonList: jsonList)
                })
                .flatMapLatest { owner, _ -> Observable<[Pokemon]> in
                    let allPokemonList = owner.dbManager.getAllPokemonList(page)
                    return .just(allPokemonList)
                }
        } else {
            return .just(pokemonList)
        }
    }

    func fetchPokemonInfo(index: Int) -> Single<PokemonInfo> {
        return .create { [weak self] single -> Disposable in
            guard let self = self else { return Disposables.create() }
            if let pokemonInfo = self.dbManager.getPokemonInfo(index) {
                single(.success(pokemonInfo))
            } else {
                self.apiManager.fetch(.pokemonInfo(index)) { [weak self] json in
                    guard let self = self else { return }
                    let pokemonInfo = self.dbManager.insertPokemonInfo(index, json: json)
                    single(.success(pokemonInfo))
                } failure: { error in
                    single(.failure(error))
                }
            }

            return Disposables.create()
        }
    }
}
