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
    static let shared = DBManager()
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

    func insertPokemonInfo(_ index: Int, json: JSON) -> PokemonInfo {
        let pokemonInfo = PokemonInfo().then {
            $0.index = index
            $0.hp = json["stats"].arrayValue[0]["base_stat"].intValue
            $0.attack = json["stats"].arrayValue[1]["base_stat"].intValue
            $0.defense = json["stats"].arrayValue[2]["base_stat"].intValue
            $0.spAttack = json["stats"].arrayValue[3]["base_stat"].intValue
            $0.spDefense = json["stats"].arrayValue[4]["base_stat"].intValue
            $0.speed = json["stats"].arrayValue[5]["base_stat"].intValue
            $0.height = json["height"].intValue
            $0.weight = json["weight"].intValue
            let typeList = List<String>()
            json["types"].arrayValue.forEach { typeJson in
                typeList.append(typeJson["type"]["name"].stringValue)
            }
            $0.typeList = typeList
        }

        try? realm.write {
            realm.add(pokemonInfo, update: .modified)
        }

        return pokemonInfo
    }

    func getPokemonInfo(_ index: Int) -> PokemonInfo? {
        realm.object(ofType: PokemonInfo.self, forPrimaryKey: index)
    }
}
