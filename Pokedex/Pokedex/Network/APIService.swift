//
//  APIService.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import Moya

enum APIService {
    case pokemonResponse(Int)
    case pokemonInfo(String)
}

extension APIService: TargetType {
    var baseURL: URL { URL(string: "https://pokeapi.co/api/v2/")! }
    var path: String {
        switch self {
        case .pokemonResponse(_):
            return "pokemon/"

        case let .pokemonInfo(name):
            return "pokemon/\(name)"
        }
    }

    var task: Task {
        switch self {
        case let .pokemonResponse(page):
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
    var sampleData: Data { Data() }
}
