//
//  PokemonListUseCaseTests.swift
//  PokemonListUseCaseTests
//
//  Created by 이준성 on 2021/05/04.
//

import XCTest
import RxSwift
import RxTest
import Moya
@testable import Pokedex

final class PokemonListUseCaseTests: XCTestCase {
    private var useCase: PokemonListUseCase!
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!

    override func setUpWithError() throws {
        let repository = MockPokemonRepository()
        self.useCase = DefaultPokemonListUseCase(repository: repository)
        self.disposeBag = DisposeBag()
        self.scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        self.disposeBag = DisposeBag()
    }

    func test_pokemon_list_success() throws {
        let testableObserver = self.scheduler.createObserver([Pokemon].self)

        self.useCase.fetchPokemonList(page: 1)
            .subscribe(testableObserver)
            .disposed(by: self.disposeBag)

        let event = testableObserver.events.first
        XCTAssertNotNil(event?.value.element)
    }

}
