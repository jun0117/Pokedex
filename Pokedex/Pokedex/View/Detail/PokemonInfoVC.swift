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
        self.title = infoVM.pokemon.name.capitalized
    }

}
