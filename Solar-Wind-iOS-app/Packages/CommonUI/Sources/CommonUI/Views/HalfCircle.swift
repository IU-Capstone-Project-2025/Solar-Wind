//
//  HalfCircle.swift
//  CommonUI
//
//  Created by Даша Николаева on 03.07.2025.
//

import UIKit

public class HalfCircleView: UIView {
    private let shapeLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    private let borderMaskLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        backgroundColor = .clear

        // Заливка белым
        shapeLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(shapeLayer)

        // Градиент для обводки
        gradientLayer.colors = [
            UIColor.mainPinkColor.cgColor,
            UIColor.mainYellowColor.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        layer.addSublayer(gradientLayer)

        // Для отладки
        gradientLayer.borderColor = UIColor.red.cgColor
        gradientLayer.borderWidth = 1

        // Маска - только stroke, без fill
        borderMaskLayer.fillColor = UIColor.clear.cgColor
        borderMaskLayer.strokeColor = UIColor.black.cgColor
        borderMaskLayer.lineWidth = 4

        gradientLayer.mask = borderMaskLayer
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updatePaths()
    }

    private func updatePaths() {
        let radius = bounds.height / 2
        let center = CGPoint(x: bounds.maxX, y: bounds.midY)

        let arcPath = UIBezierPath(arcCenter: center,
                                   radius: radius - borderMaskLayer.lineWidth / 2,
                                   startAngle: .pi / 2,
                                   endAngle: .pi * 3 / 2,
                                   clockwise: true)

        let fillPath = UIBezierPath()
        fillPath.append(arcPath)
        fillPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        fillPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        fillPath.close()

        shapeLayer.path = fillPath.cgPath
        borderMaskLayer.path = arcPath.cgPath

        gradientLayer.frame = bounds
    }
}
