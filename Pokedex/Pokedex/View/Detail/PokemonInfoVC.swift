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

        infoVM.info
            .map { $0.index }
            .map { String(format: "#%03d", $0) }
            .asDriver(onErrorJustReturn: "")
            .drive(infoView.idLabel.rx.text)
            .disposed(by: disposeBag)

        infoVM.info
            .map { $0.pokemonTypeList }
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] typeList in
                self?.infoView.setTypeList(typeList)
            }).disposed(by: disposeBag)

        infoVM.isLoading.asDriver(onErrorJustReturn: false)
            .drive(infoView.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }

}
