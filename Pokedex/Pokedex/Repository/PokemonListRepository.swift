//
//  PokemonListRepository.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/05.
//

import RxSwift

class PokemonListRepository {
    private let apiManager = APIManger()
    private let dbManager = DBManager()
    
    func fetchPokemonList(page: Int) -> Observable<[Pokemon]> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create() }
            let pokemonList = self.dbManager.getPokemonList(page)
            if pokemonList.isEmpty {
                self.apiManager.fetchPokemonList(page: page) { [weak self] json in
                    self?.dbManager.insertPokemonList(page, jsonList: json["results"].arrayValue)
                    let allPokemonList = self?.dbManager.getAllPokemonList(page)
                    observer.onNext(allPokemonList ?? [])
                    observer.onCompleted()
                } failure: { error in
                    observer.onError(error)
                }
            } else {
                let allPokemonList = self.dbManager.getAllPokemonList(page)
                observer.onNext(allPokemonList)
            }
            
            return Disposables.create()
        }
    }
}
