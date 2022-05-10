//
//  PokemonListRepository.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/05.
//

import RxSwift

final class PokemonListRepository {
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
                    let pokemonList = owner.dbManager.getPokemonList(page)
                    return .just(pokemonList)
                }
        } else {
            return .just(pokemonList)
        }
    }

    func fetchPokemonInfo(index: Int) -> Observable<PokemonInfo> {
        if let pokemonInfo = self.dbManager.getPokemonInfo(index) {
            return .just(pokemonInfo)
        } else {
            return apiManager.fetch(.pokemonInfo(index))
                .withUnretained(self)
                .flatMapLatest { owner, json -> Observable<PokemonInfo> in
                    let pokemonInfo = owner.dbManager.insertPokemonInfo(index, json: json)
                    return .just(pokemonInfo)
                }
        }
    }
}
