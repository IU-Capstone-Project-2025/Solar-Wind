//
//  ChooseCityView.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit
import CommonUI

class ChooseCityView: View {
    enum Action {
        case next
    }
    var actionHandler: (Action) -> Void = { _ in }
    
    override func setupContent() {
        backgroundColor = .white
    }
}
