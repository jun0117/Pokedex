//
//  PokemonInfo.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/07.
//

import RealmSwift

final class PokemonInfo: Object {
    @objc dynamic var index: Int = 0
    @objc dynamic var hp: Int = 0 // swiftlint:disable:this identifier_name
    @objc dynamic var weight: Int = 0
    @objc dynamic var height: Int = 0
    @objc dynamic var attack: Int = 0
    @objc dynamic var defense: Int = 0
    @objc dynamic var spAttack: Int = 0
    @objc dynamic var spDefense: Int = 0
    @objc dynamic var speed: Int = 0
    var typeList: List<String> = .init()

    override class func primaryKey() -> String? {
        "index"
    }

    var pokemonTypeList: [PokemonType] {
        typeList.map {
            PokemonType(rawValue: $0) ?? .normal
        }
    }
}
