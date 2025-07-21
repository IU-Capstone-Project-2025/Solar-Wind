//
//  GradientButton.swift
//  CommonUI
//
//  Created by Даша Николаева on 19.06.2025.
//

import UIKit

public class GradientButton: BaseRoundButton {
    public override func setup() {
        super.setup()
        addGradientBackgroundView()
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        setTitleColor(.white, for: .normal)
    }
}
