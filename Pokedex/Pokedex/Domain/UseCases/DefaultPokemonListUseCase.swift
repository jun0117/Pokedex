//
//  DefaultPokemonListUseCase.swift
//  Pokedex
//
//  Created by 이준성 on 2022/05/11.
//

import RxSwift

final class DefaultPokemonListUseCase: PokemonListUseCase {
    private let repository: PokemonRepository

    init(repository: PokemonRepository) {
        self.repository = repository
    }

    func fetchPokemonList(page: Int) -> Observable<[Pokemon]> {
        return repository.fetchPokemonList(page: page)
    }

    func fetchPokemonInfo(index: Int) -> Observable<PokemonInfo> {
        return repository.fetchPokemonInfo(index: index)
    }
}
