//
//  PokemonInfoVC.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/07.
//

import UIKit
import RxSwift
import RxCocoa

final class PokemonInfoVC: BaseViewController<PokemonInfoVM, PokemonInfoView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        bindOutput()
        viewModel.input.viewDidLoad.onNext(())
    }

    private func bindOutput() {
        viewModel.output.pokemon
            .bind(to: self.rx.pokemon)
            .disposed(by: disposeBag)

        viewModel.output.pokemonInfo
            .bind(with: self) { owner, info in
                owner.contentView.setPokeInfo(info)
            }.disposed(by: disposeBag)

        viewModel.output.isLoading
            .bind(to: contentView.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }

}

extension Reactive where Base: PokemonInfoVC {
    var pokemon: Binder<Pokemon> {
        Binder(base) { base, pokemon in
            base.contentView.pokemonImage.setImage(with: pokemon.imageUrl)
            base.contentView.pokemonName.text = pokemon.name.capitalized
        }
    }
}
