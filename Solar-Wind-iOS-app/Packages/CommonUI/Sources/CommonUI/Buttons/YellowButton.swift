//
//  YellowButton.swift
//  CommonUI
//
//  Created by Даша Николаева on 22.06.2025.
//

import UIKit

public class YellowButton: BaseRoundButton {
    public override func setup() {
        super.setup()
        backgroundColor = .transparentYellowColor
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        addTarget(self, action: #selector(toggleSelected), for: .touchUpInside)
        updateAppearance()
    }
    
    @objc private func toggleSelected() {
        isSelected.toggle()
        updateAppearance()
    }

    private func updateAppearance() {
        backgroundColor = isSelected ? .orangeColor : .transparentYellowColor
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        setTitleColor(.black, for: .normal)
    }
}

