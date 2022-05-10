//
//  AppDelegate.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/04.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let pokemonListVC = PokemonListVC(viewModel: .init(repository: .init()))
        window?.rootViewController = UINavigationController(rootViewController: pokemonListVC)
        window?.makeKeyAndVisible()
        return true
    }

}
