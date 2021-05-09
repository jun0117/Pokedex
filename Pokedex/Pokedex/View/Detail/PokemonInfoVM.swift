//
//  PokemonInfoVM.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/07.
//

import RxSwift
import RxCocoa

class PokemonInfoVM {
    private let repository: PokemonListRepository
    var pokemon: Pokemon
    var isLoading = BehaviorRelay<Bool>(value: false)
    var info = BehaviorRelay<PokemonInfo>(value: .init())

    init(_ pokemon: Pokemon, repository: PokemonListRepository) {
        self.repository = repository
        self.pokemon = pokemon
        fetchPokemonInfo()
    }

    private func fetchPokemonInfo() {
        isLoading.accept(true)
        _ = repository.fetchPokemonInfo(index: pokemon.index)
            .retry(3)
            .subscribe { [weak self] pokemonInfo in
                self?.info.accept(pokemonInfo)
                self?.isLoading.accept(false)
            } onFailure: { [weak self] error in
                self?.isLoading.accept(false)
                print(error.localizedDescription)
            }
    }
}
