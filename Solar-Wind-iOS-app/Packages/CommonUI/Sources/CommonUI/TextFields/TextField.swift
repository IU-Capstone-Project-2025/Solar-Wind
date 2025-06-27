//
//  TextField.swift
//  CommonUI
//
//  Created by Даша Николаева on 22.06.2025.
//

import UIKit

public final class TextField: UITextField {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 8.0
        clipsToBounds = true
        textColor = .black
        font = .systemFont(ofSize: 16)
        setLeftPadding(12)
        setRightPadding(12)
    }

    private func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }

    private func setRightPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
