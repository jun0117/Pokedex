//
//  ViewController.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import UIKit
import RxSwift
import RxCocoa

class PokemonListVC: BaseViewController<PokemonListVM, PokemonListView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokedex"
        bindInput()
        bindOutput()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.input.viewDidAppear.onNext(())
    }

    private func bindInput() {
        contentView.collectionView.rx
            .willDisplayCell
            .throttle(.milliseconds(100), scheduler: MainScheduler.instance)
            .filter { [weak self] _, indexPath in
                guard let count = self?.contentView.collectionView.numberOfItems(inSection: 0) else {
                    return false
                }
                return indexPath.row + 1 == count
            }
            .map { _ in () }
            .bind(to: viewModel.input.fetchMore)
            .disposed(by: disposeBag)

        contentView.collectionView.rx
            .modelSelected(Pokemon.self)
            .bind(with: self) { owner, pokemon in
                let pokemonInfoVC = PokemonInfoVC()
                pokemonInfoVC.infoVM = PokemonInfoVM(pokemon, repository: .init())
                owner.navigationController?.present(pokemonInfoVC, animated: true)
            }.disposed(by: disposeBag)
    }

    private func bindOutput() {
        viewModel.output.pokemonList
            .drive(contentView.collectionView.rx.items(cellIdentifier: PokemonListCell.id, cellType: PokemonListCell.self)) { _, pokemon, cell in
                cell.configure(pokemon)
            }.disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .bind(to: contentView.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.output.noMoreData
            .filter { $0 }
            .bind(with: self) { _, _ in
                print("noMoreData")
            }.disposed(by: disposeBag)
    }
}
