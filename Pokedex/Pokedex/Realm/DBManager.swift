//
//  DBManager.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/05.
//

import SwiftyJSON
import RealmSwift
import Then

class DBManager {
    private let realm = try! Realm() // swiftlint:disable:this force_try

    func insertPokemonList(_ page: Int, jsonList: [JSON]) {
        let pokemonList = jsonList.map { json -> Pokemon in
            return Pokemon().then {
                let url = json["url"].stringValue
                let index = Int(url.split(separator: "/").last!)!
                $0.index = index
                $0.name = json["name"].stringValue
                $0.url = url
                $0.page = page
            }
        }

        try? realm.write {
            realm.add(pokemonList, update: .modified)
        }
    }

    func getPokemonList(_ page: Int) -> [Pokemon] {
        let pokemonList = realm.objects(Pokemon.self)
            .filter { $0.page == page }
            .sorted(by: { $0.index < $1.index })
        return Array(pokemonList)
    }

    func getAllPokemonList(_ page: Int) -> [Pokemon] {
        let pokemonList = realm.objects(Pokemon.self)
            .filter { $0.page <= page }
            .sorted(by: { $0.index < $1.index })
        return Array(pokemonList)
    }
}
