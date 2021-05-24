//
//  PokemonInfoView.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/07.
//

import UIKit
import SnapKit

class PokemonInfoView: UIView {
    private let scrollView = UIScrollView()
    private let innerView = UIView()

    private let headerView = UIView()
    let idLabel = UILabel()
    let pokemonImage = UIImageView()
    let pokemonName = UILabel()
    private let typeStackView = UIStackView()

    private let footerView = UIView()
    private let weightLabel = UILabel()
    private let heightLabel = UILabel()

    let activityIndicator = UIActivityIndicatorView()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setScrollView()
        setHeaderView()
        setFooterView()
        setIndicator()
    }

    private func setScrollView() {
        scrollView.do {
            addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.bottom.equalTo(safeAreaLayoutGuide)
                make.left.right.equalToSuperview()
                make.height.equalTo(safeAreaLayoutGuide)
            }
        }

        innerView.do {
            scrollView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.right.top.bottom.equalToSuperview()
                make.width.height.equalToSuperview()
            }
        }
    }

    private func setHeaderView() {
        headerView.do {
            innerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
            }
            $0.backgroundColor = .white
        }

        pokemonName.do {
            headerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(20)
                make.left.equalToSuperview().offset(20)
                make.centerX.equalToSuperview()
            }
            $0.textColor = .white
            $0.font = .boldSystemFont(ofSize: 40)
        }

        typeStackView.do {
            headerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(pokemonName.snp.bottom).offset(4)
                make.left.equalTo(pokemonName)
                make.height.equalTo(40)
            }
        }

        idLabel.do {
            headerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(20)
                make.centerY.equalTo(pokemonName)
            }
            $0.textColor = .white
            $0.font = .boldSystemFont(ofSize: 30)
        }

        pokemonImage.do {
            headerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.width.height.equalTo(200)
                make.centerX.equalToSuperview()
                make.top.equalTo(typeStackView.snp.bottom).offset(20)
                make.bottom.equalToSuperview().inset(20)
            }
            $0.contentMode = .scaleAspectFit
        }
    }

    private func setFooterView() {
        footerView.do {
            innerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(headerView.snp.bottom).inset(20)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            $0.roundCorners([.leftTop, .rightTop], radius: 20)
            $0.backgroundColor = .white
        }

        setWeightHeightView()
    }

    private func setWeightHeightView() {
        let divider = UIView().then {
            footerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(40)
                make.centerX.equalToSuperview()
                make.width.equalTo(1)
            }
            $0.backgroundColor = .separator
        }

        let weightTitleLabel = UILabel().then {
            footerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.right.equalTo(divider.snp.left)
                make.centerY.equalTo(divider)
            }
            $0.text = "Weight"
            $0.font = .boldSystemFont(ofSize: 17)
            $0.textAlignment = .center
        }

        weightLabel.do {
            footerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(weightTitleLabel.snp.bottom).offset(12)
                make.centerX.equalTo(weightTitleLabel)
            }
            $0.font = .systemFont(ofSize: 15)
        }

        let heightTitleLabel = UILabel().then {
            footerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.equalTo(divider.snp.right)
                make.right.equalToSuperview()
                make.centerY.equalTo(divider)
            }
            $0.text = "Height"
            $0.font = .boldSystemFont(ofSize: 17)
            $0.textAlignment = .center
        }

        heightLabel.do {
            footerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(heightTitleLabel.snp.bottom).offset(12)
                make.centerX.equalTo(heightTitleLabel)
            }
            $0.font = .systemFont(ofSize: 15)
        }
    }

    func setPokeInfo(_ pokeInfo: PokemonInfo) {
        idLabel.text = String(format: "#%03d", pokeInfo.index)
        weightLabel.text = String(format: "%.1f kg", Float(pokeInfo.weight) / 10)
        heightLabel.text = String(format: "%.1f m", Float(pokeInfo.height) / 10)

        setTypeList(pokeInfo.pokemonTypeList)
        setStatProgressView(pokeInfo)
    }

    private func setTypeList(_ typeList: [PokemonType]) {
        typeList.forEach {
            let imageView = UIImageView(image: .init(named: $0.name.capitalized))
            typeStackView.addArrangedSubview(imageView)
        }

        headerView.backgroundColor = typeList.first?.color
    }

    private func setStatProgressView(_ pokeInfo: PokemonInfo) {
        let statViewList = [
            makeProgressView(name: "Hp", value: pokeInfo.hp, color: .green),
            makeProgressView(name: "Speed", value: pokeInfo.speed, color: .lightGray),
            makeProgressView(name: "Attack", value: pokeInfo.attack, color: .red),
            makeProgressView(name: "Defense", value: pokeInfo.defense, color: .blue),
            makeProgressView(name: "Sp.Atk", value: pokeInfo.spAttack, color: .purple),
            makeProgressView(name: "Sp.Def", value: pokeInfo.spDefense, color: .yellow)
        ]

        UIStackView(arrangedSubviews: statViewList).do {
            footerView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(weightLabel.snp.bottom).offset(32)
                make.left.right.equalToSuperview()
            }
            $0.axis = .vertical
            $0.spacing = 8
        }
    }

    private func makeProgressView(name: String, value: Int, color: UIColor) -> UIView {
        let container = UIView().then {
            $0.snp.makeConstraints { make in
                make.width.equalTo(UIScreen.main.bounds.width)
                make.height.equalTo(30)
            }
        }

        let nameLabel = UILabel().then {
            container.addSubview($0)
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(32)
                make.width.equalTo(70)
            }
            $0.text = name
            $0.font = .systemFont(ofSize: 15)
        }

        let valueLabel = UILabel().then {
            container.addSubview($0)
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(nameLabel.snp.right).offset(8)
                make.width.equalTo(30)
            }
            $0.text = "\(value)"
            $0.font = .systemFont(ofSize: 15)
        }

        UIProgressView().do {
            container.addSubview($0)
            $0.snp.makeConstraints { make in
                make.centerY.equalTo(valueLabel)
                make.left.equalTo(valueLabel.snp.right).offset(20)
                make.right.equalToSuperview().inset(32)
                make.height.equalTo(8)
            }
            $0.progress = Float(value) / 200
            $0.progressTintColor = color
            $0.trackTintColor = .white
            $0.layer.borderColor = UIColor.separator.cgColor
            $0.layer.borderWidth = 0.5
            $0.layer.cornerRadius = 4
        }

        return container
    }

    private func setIndicator() {
        activityIndicator.do {
            addSubview($0)
            $0.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            $0.style = .large
            $0.color = .red
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
