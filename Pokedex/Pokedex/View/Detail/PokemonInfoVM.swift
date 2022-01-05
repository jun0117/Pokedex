//
//  PokemonInfoVM.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/07.
//

import RxSwift
import RxCocoa

class PokemonInfoVM: BaseViewModel {
    struct Input {
        let viewDidAppear: AnyObserver<Void>
    }

    struct Output {
        let pokemon: Observable<Pokemon>

        let pokemonInfo: Observable<PokemonInfo>

        let isLoading: Observable<Bool>
    }

    private(set) var input: Input!
    private(set) var output: Output!

    private let repository: PokemonListRepository
    private let pokemon: Pokemon

    // Input
    private let viewDidAppear = PublishSubject<Void>()

    init(_ pokemon: Pokemon, repository: PokemonListRepository) {
        self.pokemon = pokemon
        self.repository = repository
        self.input = Input(viewDidAppear: viewDidAppear.asObserver())
        self.output = initOutput()
    }

    private func initOutput() -> Output {
        let isLoading = BehaviorRelay<Bool>(value: false)

        let pokemonInfo = viewDidAppear
            .filter { isLoading.value == false }
            .do(onNext: { _ in isLoading.accept(true) })
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.repository.fetchPokemonInfo(index: owner.pokemon.index)
            }
            .do(onNext: { _ in isLoading.accept(false) })

        return Output(pokemon: .just(pokemon),
                      pokemonInfo: pokemonInfo,
                      isLoading: isLoading.asObservable())
    }
}
