//
//  PokemonInfoVM.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/07.
//

import RxSwift
import RxCocoa

class PokemonInfoVM {
    var pokemon: Pokemon

    init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}
