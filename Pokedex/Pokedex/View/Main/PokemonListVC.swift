//
//  ViewController.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import UIKit

class PokemonListVC: UIViewController {
    private var listView: PokemonListView { view as! PokemonListView }
    var listVM: PokemonListVM!
    
    override func loadView() {
        view = PokemonListView()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

