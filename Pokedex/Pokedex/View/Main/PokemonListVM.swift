//
//  PokemonListVM.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/05.
//

import RxSwift
import RxCocoa

class PokemonListVM {
    private let repository: PokemonListRepository
    private var disposeBag = DisposeBag()
    var pokemonList = BehaviorRelay<[Pokemon]>(value: [])
    var isLoading = PublishRelay<Bool>()
    private var page = 0
    private var isPaging = false

    init(_ repository: PokemonListRepository) {
        self.repository = repository
        fetchPokemonList(page: 0)
    }

    private func fetchPokemonList(page: Int) {
        isPaging = true
        isLoading.accept(true)
        _ = repository.fetchPokemonList(page: page)
            .retry(3)
            .subscribe { [weak self] list in
                self?.pokemonList.accept(list)
                self?.isPaging = false
                self?.isLoading.accept(false)
            } onFailure: { [weak self] error in
                self?.isLoading.accept(false)
                print(error.localizedDescription)
            }
    }

    func fetchNextPage() {
        if !isPaging {
            page += 1
            fetchPokemonList(page: page)
        }
    }
}
