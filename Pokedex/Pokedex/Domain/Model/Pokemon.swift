//
//  Pokemon.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import RealmSwift
import SwiftyJSON

final class Pokemon: Object {
    @objc dynamic var index: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var page: Int = 0

    override class func primaryKey() -> String? {
        "name"
    }

    var imageUrl: String { "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(index).png" }

    class func fromJSON(_ json: JSON, page: Int) -> Pokemon {
        Pokemon().then {
            let url = json["url"].stringValue
            let index = Int(url.split(separator: "/").last!)!
            $0.index = index
            $0.name = json["name"].stringValue
            $0.url = url
            $0.page = page
        }
    }
}
