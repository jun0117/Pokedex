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
    }
}
