//
//  WhiteButton.swift
//  CommonUI
//
//  Created by Даша Николаева on 10.06.2025.
//

import UIKit

public class WhiteButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
//        titleLabel?.font = .size20Medium
        titleLabel?.font = .systemFont(ofSize: 20)
        setTitleColor(.black, for: .normal)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
