//
//  PokemonListUseCase.swift
//  Pokedex
//
//  Created by 이준성 on 2022/05/11.
//

import RxSwift

protocol PokemonListUseCase {
    func fetchPokemonList(page: Int) -> Observable<[Pokemon]>
    func fetchPokemonInfo(index: Int) -> Observable<PokemonInfo>
}
