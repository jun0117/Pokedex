//
//  PokemonListCell.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/06.
//

import UIKit
import SnapKit
import Kingfisher

final class PokemonListCell: UICollectionViewCell {
    let container = UIView()
    let nameLabel = UILabel()
    let image = UIImageView()

    func configure(_ pokemon: Pokemon) {
        nameLabel.text = pokemon.name.capitalized
        image.kf.setImage(with: URL(string: pokemon.imageUrl))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setContainer()
        setNameLabel()
        setImage()
    }

    private func setContainer() {
        container.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.bottom.left.right.equalToSuperview()
            }
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.addSubview(nameLabel)
            $0.addSubview(image)
        }
    }

    private func setNameLabel() {
        nameLabel.do {
            $0.snp.makeConstraints { make in
                make.top.equalTo(image.snp.bottom)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(50)
            }
            $0.font = .boldSystemFont(ofSize: 14)
            $0.textColor = .black
            $0.textAlignment = .center
        }
    }

    private func setImage() {
        image.do {
            $0.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(20)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().inset(20)
                make.bottom.equalTo(nameLabel.snp.top)
            }
            $0.contentMode = .scaleAspectFit
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
