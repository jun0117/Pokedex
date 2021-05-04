//
//  Pokemon.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import SwiftyJSON

struct Pokemon {
    let name: String
    let url: String
    let imageUrl: String
    
    init(_ json: JSON) {
        name = json["name"].stringValue
        url = json["url"].stringValue
        let index = url.split(separator: "/").last!
        imageUrl = "https://pokeres.bastionbot.org/images/pokemon/\(index).png"
    }
}
