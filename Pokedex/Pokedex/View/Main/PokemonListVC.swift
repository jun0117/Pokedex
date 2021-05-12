//
//  ViewController.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import UIKit
import RxSwift

class PokemonListVC: UIViewController {
    private var listView: PokemonListView { view as! PokemonListView }
    private var disposeBag = DisposeBag()
    var listVM: PokemonListVM!

    override func loadView() {
        view = PokemonListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokedex"
        bind()
    }

    private func bind() {
        listVM.pokemonList.asDriver()
            .drive(listView.collectionView.rx.items(cellIdentifier: PokemonListCell.id, cellType: PokemonListCell.self)) { _, pokemon, cell in
                cell.configure(pokemon)
            }.disposed(by: disposeBag)

        listVM.isLoading.asDriver(onErrorJustReturn: false)
            .drive(listView.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        listView.collectionView.rx.willDisplayCell.asDriver()
            .throttle(.milliseconds(100))
            .drive { [weak self] _, index in
                guard let count = self?.listView.collectionView.numberOfItems(inSection: 0) else { return }
                if index.row + 1 == count {
                    self?.listVM.fetchNextPage()
                }
            }.disposed(by: disposeBag)

        listView.collectionView.rx.modelSelected(Pokemon.self).bind { [weak self] pokemon in
            let pokemonInfoVC = PokemonInfoVC()
            pokemonInfoVC.infoVM = PokemonInfoVM(pokemon, repository: .init())
            self?.navigationController?.present(pokemonInfoVC, animated: true)
        }.disposed(by: disposeBag)
    }
}
