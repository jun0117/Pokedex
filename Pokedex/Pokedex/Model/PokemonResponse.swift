//
//  PokemonResponse.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import SwiftyJSON

struct PokemonResponse {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
    
    init(_ json: JSON) {
        count = json["count"].intValue
        next = json["next"].string
        previous = json["previous"].string
        results = json["results"].arrayValue.map { Pokemon($0) }
    }

}
