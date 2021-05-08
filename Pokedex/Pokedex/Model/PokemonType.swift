//
//  PokemonType.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/08.
//

import UIKit

enum PokemonType: String {
    case normal, fire, water, grass, electric, ice, fighting, poison, ground,
         flying, psychic, bug, rock, ghost, dark, dragon, steel, fiary

    var name: String { self.rawValue.capitalized }

    var color: UIColor {
        switch self {
        case .normal: return UIColor(rgb: 0xA8A878)
        case .fire: return UIColor(rgb: 0xF08030)
        case .water: return UIColor(rgb: 0x6890F0)
        case .grass: return UIColor(rgb: 0x78C850)
        case .electric: return UIColor(rgb: 0xF8D030)
        case .ice: return UIColor(rgb: 0x98D8D8)
        case .fighting: return UIColor(rgb: 0xC03029)
        case .poison: return UIColor(rgb: 0xA040A0)
        case .ground: return UIColor(rgb: 0xE0C068)
        case .flying: return UIColor(rgb: 0xA890F0)
        case .psychic: return UIColor(rgb: 0xF85888)
        case .bug: return UIColor(rgb: 0xA8B81F)
        case .rock: return UIColor(rgb: 0xB8A038)
        case .ghost: return UIColor(rgb: 0x705898)
        case .dark: return UIColor(rgb: 0x705848)
        case .dragon: return UIColor(rgb: 0x7038F8)
        case .steel: return UIColor(rgb: 0xB8B8D0)
        case .fiary: return UIColor(rgb: 0xF0B6BC)
        }
    }
}
