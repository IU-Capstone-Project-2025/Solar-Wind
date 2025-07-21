//
//  WhiteButton.swift
//  CommonUI
//
//  Created by Даша Николаева on 10.06.2025.
//

import UIKit

public class WhiteButton: BaseRoundButton {
    public override func setup() {
        super.setup()
        backgroundColor = .white
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        setTitleColor(.black, for: .normal)
    }
}
