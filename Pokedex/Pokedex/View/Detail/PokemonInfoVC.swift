//
//  PokemonInfoVC.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/07.
//

import UIKit
import RxSwift
import RxCocoa

class PokemonInfoVC: UIViewController {
    private var infoView: PokemonInfoView { view as! PokemonInfoView }
    private var disposeBag = DisposeBag()
    var infoVM: PokemonInfoVM!

    override func loadView() {
        view = PokemonInfoView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        infoView.pokemonImage.kf.setImage(with: URL(string: infoVM.pokemon.imageUrl))
        infoView.pokemonName.text = infoVM.pokemon.name.capitalized

        infoVM.info.asDriver(onErrorJustReturn: .init())
            .drive(onNext: { [weak self] info in
                self?.infoView.setPokeInfo(info)
            }).disposed(by: disposeBag)

        infoVM.isLoading.asDriver(onErrorJustReturn: false)
            .drive(infoView.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        infoVM.fetchPokemonInfo()
    }

}
