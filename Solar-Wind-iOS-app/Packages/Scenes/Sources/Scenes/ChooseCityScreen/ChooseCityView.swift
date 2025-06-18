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
    
    private lazy var searchView: SearchView = {
        let view = SearchView(placeholder: "Search...")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupContent() {
        backgroundColor = .white
        addSubview(searchView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            searchView.heightAnchor.constraint(equalToConstant: 45),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
