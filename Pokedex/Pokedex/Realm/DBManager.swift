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
                $0.name = json["name"].stringValue
                $0.url = json["url"].stringValue
                $0.page = page
            }
        }

        try? realm.write {
            realm.add(pokemonList, update: .modified)
        }
    }

    func getPokemonList(_ page: Int) -> [Pokemon] {
        let pokemonList = realm.objects(Pokemon.self).filter { $0.page == page }
        return Array(pokemonList)
    }

    func getAllPokemonList(_ page: Int) -> [Pokemon] {
        let pokemonList = realm.objects(Pokemon.self).filter { $0.page <= page }
        return Array(pokemonList)
    }
}
