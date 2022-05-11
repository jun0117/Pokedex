//
//  Ext.swift
//  Pokedex
//
//  Created by 이준성 on 2021/05/06.
//

import UIKit
import Moya

extension UIView {
    static var id: String { String(describing: self) } // swiftlint:disable:this identifier_name

    func roundCorners(_ corners: [Corner], radius: CGFloat) {
        var caCorners = CACornerMask()

        corners.forEach { corner in
            switch corner {
            case .leftTop: caCorners.insert(.layerMinXMinYCorner)
            case .leftBottom: caCorners.insert(.layerMinXMaxYCorner)
            case .rightTop: caCorners.insert(.layerMaxXMinYCorner)
            default: caCorners.insert(.layerMaxXMaxYCorner)
            }
        }
        roundCorners(corners: caCorners, radius: radius)
    }

    private func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius
    }

    enum Corner {
        case leftTop, leftBottom, rightTop, rightBottom
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
}

extension TargetType {
    static func stubbedResponse(fileName: String) -> Data {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            return data
        }
        return Data()
    }
}
