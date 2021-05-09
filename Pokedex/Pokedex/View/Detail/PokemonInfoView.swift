//
//  PokemonInfoView.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/07.
//

import UIKit
import SnapKit

class PokemonInfoView: UIView {
    var activityIndicator = UIActivityIndicatorView()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setIndicator()
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
