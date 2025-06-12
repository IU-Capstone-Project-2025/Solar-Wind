//
//  GradientBackground.swift
//  CommonUI
//
//  Created by Даша Николаева on 11.06.2025.
//

import UIKit

final class GradientBackgroundView: UIView {
    
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }

    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.mainYellowColor.cgColor,
            UIColor.mainPinkColor.cgColor
        ]
        gradientLayer.locations = [0.1971, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.2, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 1.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
