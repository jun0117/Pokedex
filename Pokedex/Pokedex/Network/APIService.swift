//
//  APIService.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import Moya

enum APIService {
    case pokemonList(Int)
    case pokemonInfo(Int)
}

extension APIService: TargetType {
    var baseURL: URL { URL(string: "https://pokeapi.co/api/v2/")! }
    var path: String {
        switch self {
        case .pokemonList:
            return "pokemon/"

        case let .pokemonInfo(index):
            return "pokemon/\(index)"
        }
    }

    var task: Task {
        switch self {
        case let .pokemonList(page):
            let pageSize = 20
            let params: [String: Any?] = [
                "limit": pageSize,
                "offset": page * pageSize
            ]

            return .requestParameters(
                parameters: params.compactMapValues { $0 },
                encoding: URLEncoding.queryString
            )

        default: return .requestPlain
        }
    }

    var headers: [String: String]? { [:] }
    var method: Method { .get }
    var sampleData: Data {
        switch self {
        case .pokemonList(let page):
            return Self.stubbedResponse(fileName: "MockPokemonList_\(page)")

        case .pokemonInfo(_):
            return Data()
        }
    }
}
