//
//  PokemonListVM.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/05.
//

import RxSwift
import RxCocoa

class PokemonListVM {
    private let repository: PokemonListRepository
    var pokemonList = BehaviorRelay<[Pokemon]>(value: [])

    init(_ repository: PokemonListRepository) {
        self.repository = repository
        fetchPokemonList(page: 0)
    }

    private func fetchPokemonList(page: Int) {
        _ = repository.fetchPokemonList(page: page)
            .retry(3)
            .take(1)
            .subscribe { [weak self] list in
                self?.pokemonList.accept(list)
            } onError: { error in
                print(error.localizedDescription)
            }
    }
}
