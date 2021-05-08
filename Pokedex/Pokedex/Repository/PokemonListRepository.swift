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

    func fetchPokemonList(page: Int) -> Single<[Pokemon]> {
        return .create { [weak self] single -> Disposable in
            guard let self = self else { return Disposables.create() }
            let pokemonList = self.dbManager.getPokemonList(page)
            if pokemonList.isEmpty {
                self.apiManager.fetch(.pokemonList(page)) { [weak self] json in
                    self?.dbManager.insertPokemonList(page, jsonList: json["results"].arrayValue)
                    let allPokemonList = self?.dbManager.getAllPokemonList(page)
                    single(.success(allPokemonList ?? []))
                } failure: { error in
                    single(.failure(error))
                }
            } else {
                let allPokemonList = self.dbManager.getAllPokemonList(page)
                single(.success(allPokemonList))
            }

            return Disposables.create()
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
