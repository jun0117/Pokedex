//
//  Pokemon.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import RealmSwift

final class Pokemon: Object {
    @objc dynamic var index: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var page: Int = 0

    override class func primaryKey() -> String? {
        "name"
    }

    var imageUrl: String { "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(index).png" }
}
