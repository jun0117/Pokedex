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
        let vc = PokemonListVC()
        let repository = PokemonListRepository()
        vc.listVM = PokemonListVM(repository)
        
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
        return true
    }

}
