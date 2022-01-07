//
//  PokemonListVM.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/05.
//

import RxSwift
import RxCocoa

class PokemonListVM: BaseViewModel {
    struct Input {
        let viewDidAppear: AnyObserver<Void>
        
        let fetchMore: AnyObserver<Void>
    }
    
    struct Output {
        let pokemonList: Driver<[Pokemon]>
        
        let isLoading: Observable<Bool>
        
        let noMoreData: Observable<Bool>
    }

    private(set) var input: Input!
    private(set) var output: Output!

    private let repository: PokemonListRepository
    private var page = 0

    // Input
    private let viewDidAppear = PublishSubject<Void>()
    private let fetchMore = PublishSubject<Void>()

    init(_ repository: PokemonListRepository) {
        self.repository = repository
        self.input = Input(
            viewDidAppear: viewDidAppear.asObserver(),
            fetchMore: fetchMore.asObserver()
        )

        self.output = initOutput()
    }

    private func initOutput() -> Output {
        let isLoading = BehaviorRelay<Bool>(value: false)
        let noMoreData = BehaviorRelay<Bool>(value: false)

        let pokemonList = Observable
            .merge(viewDidAppear.take(1), fetchMore)
            .filter { isLoading.value == false }
            .do(onNext: { _ in isLoading.accept(true) })
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.repository.fetchPokemonList(page: owner.page)
            }
            .do(onNext: { [weak self] pokemonList in
                self?.page += 1
                if pokemonList.isEmpty {
                    noMoreData.accept(true)
                }
            })
            .scan([]) { prev, new -> [Pokemon] in
                new.isEmpty ? prev : prev + new
            }
            .do(onNext: { _ in isLoading.accept(false) })

        return Output(
            pokemonList: pokemonList.asDriver(onErrorJustReturn: []),
            isLoading: isLoading.asObservable(),
            noMoreData: noMoreData.asObservable()
        )
    }
}
