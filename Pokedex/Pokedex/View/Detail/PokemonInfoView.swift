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
    }

    private func setTypeList(_ typeList: [PokemonType]) {
        typeList.forEach {
            let imageView = UIImageView(image: .init(named: $0.name.capitalized))
            typeStackView.addArrangedSubview(imageView)
        }

        headerView.backgroundColor = typeList.first?.color
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
