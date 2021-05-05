//
//  APIManager.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import Moya
import SwiftyJSON

struct APIManger {
    
    private let provider = MoyaProvider<APIService>()
    
    func fetchPokemonList(page: Int, completion: @escaping (PokemonResponse) -> (), failure: @escaping (String) -> ()) {
        provider.request(.pokemonResponse(page)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                completion(PokemonResponse(json))
                
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }
}
