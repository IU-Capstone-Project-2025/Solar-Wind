//
//  BaseRoundButton.swift
//  CommonUI
//
//  Created by Даша Николаева on 15.06.2025.
//

import UIKit

public class BaseRoundButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    public func setup() {
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        addTarget(self, action: #selector(animateColorDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateColorUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
//        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
//        addTarget(self, action: #selector(animateUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        titleLabel?.font = .size20Medium
//        titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    @objc private func animateColorDown(sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                      delay: 0,
                      options: [.allowUserInteraction, .curveEaseIn],
                      animations: {
//            self.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
            self.layer.shadowOpacity = 0.15
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }
    
    @objc private func animateColorUp(sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                      delay: 0,
                      options: [.allowUserInteraction, .curveEaseOut],
                      animations: {
            self.backgroundColor = .white
            self.layer.shadowOpacity = 0.25
            self.transform = .identity
        }, completion: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
