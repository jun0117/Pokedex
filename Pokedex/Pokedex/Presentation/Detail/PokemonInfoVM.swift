//
//  PokemonInfoVM.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/07.
//

import RxSwift
import RxCocoa

final class PokemonInfoVM: BaseViewModel {
    struct Input {
        let viewDidLoad: AnyObserver<Void>
    }

    struct Output {
        let pokemon: Observable<Pokemon>

        let pokemonInfo: Observable<PokemonInfo>

        let isLoading: Observable<Bool>
    }

    private(set) var input: Input!
    private(set) var output: Output!

    private let useCase: PokemonListUseCase
    private let pokemon: Pokemon

    // Input
    private let viewDidLoad = PublishSubject<Void>()

    init(_ pokemon: Pokemon, useCase: PokemonListUseCase) {
        self.pokemon = pokemon
        self.useCase = useCase
        self.input = Input(viewDidLoad: viewDidLoad.asObserver())
        self.output = initOutput()
    }

    private func initOutput() -> Output {
        let isLoading = BehaviorRelay<Bool>(value: false)

        let pokemonInfo = viewDidLoad
            .filter { isLoading.value == false }
            .do(onNext: { _ in isLoading.accept(true) })
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.useCase.fetchPokemonInfo(index: owner.pokemon.index)
            }
            .do(onNext: { _ in isLoading.accept(false) })

        return Output(pokemon: .just(pokemon),
                      pokemonInfo: pokemonInfo,
                      isLoading: isLoading.asObservable())
    }
}
