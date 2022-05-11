//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/05.
//

import RxSwift

protocol PokemonRepository {
    func fetchPokemonList(page: Int) -> Observable<[Pokemon]>
    func fetchPokemonInfo(index: Int) -> Observable<PokemonInfo>
}
