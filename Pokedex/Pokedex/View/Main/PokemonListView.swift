//
//  PokemonListView.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/06.
//

import UIKit
import SnapKit

final class PokemonListView: UIView {
    var collectionView: UICollectionView!
    var activityIndicator = UIActivityIndicatorView()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setCollectionView()
        setIndicator()
    }

    private func setCollectionView() {
        let flowLayout = UICollectionViewFlowLayout().then {
            let cellCountPerRow: CGFloat = 2
            let sideSpacing: CGFloat = 12.0
            let spacingBetweenCell: CGFloat = 8
            let totalSpacing = (2 * sideSpacing) + (cellCountPerRow - 1) * spacingBetweenCell
            let length: CGFloat = (UIScreen.main.bounds.width - totalSpacing) / cellCountPerRow
            $0.itemSize = CGSize(width: length, height: length)
            $0.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
            addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.bottom.equalTo(safeAreaLayoutGuide)
            }
            $0.backgroundColor = .systemBackground
            $0.register(PokemonListCell.self, forCellWithReuseIdentifier: PokemonListCell.id)
        }
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
