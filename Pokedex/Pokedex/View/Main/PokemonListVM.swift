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
    private var page = BehaviorRelay<Int>(value: 0)

    init(_ repository: PokemonListRepository) {
        self.repository = repository
        fetchPokemonList(page: 0)
        bindNextPage()
    }

    private func fetchPokemonList(page: Int) {
        isLoading.accept(true)
        _ = repository.fetchPokemonList(page: page)
            .retry(3)
            .take(1)
            .subscribe { [weak self] list in
                self?.pokemonList.accept(list)
                self?.isLoading.accept(false)
            } onError: { [weak self] error in
                self?.isLoading.accept(false)
                print(error.localizedDescription)
            }
    }

    private func bindNextPage() {
        page.bind { [weak self] page in
            self?.fetchPokemonList(page: page)
        }.disposed(by: disposeBag)
    }

    func fetchNextPage() {
        page.accept(page.value + 1)
    }
}
