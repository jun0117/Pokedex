//
//  Pokemon.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import RealmSwift

class Pokemon: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var page: Int = 0
    
    override class func primaryKey() -> String? {
        "name"
    }
    
    var imageUrl: String {
        let index = url.split(separator: "/").last!
        return "https://pokeres.bastionbot.org/images/pokemon/\(index).png"
    }
}
