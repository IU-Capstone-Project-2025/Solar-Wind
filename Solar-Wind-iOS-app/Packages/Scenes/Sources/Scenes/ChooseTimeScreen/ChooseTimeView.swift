//
//  ChooseTimeView.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit
import CommonUI

class ChooseTimeView: View {
    enum Action {
        case next
        case back
    }

    var actionHandler: (Action) -> Void = { _ in }

    private lazy var header = addGradientHeader(text: "Before you start...", backButton: true) { [weak self] in
        self?.actionHandler(.back)
    }
    private var selectedIndexes = Set<Int>()

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "What time is convenient for you to exercise?"
        view.font = .size20Medium
        view.numberOfLines = 2
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackView = UIStackView()

    private lazy var nextButton: UIButton = {
        let button = GradientButton()
        button.title = "Continue"
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.saveSelection()
            self?.actionHandler(.next)
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func setupContent() {
        backgroundColor = .white

        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(nextButton)

        setupStackView()
        loadSelection()
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false

        for day in ChooseTime.Weekday.allCases {
            let button = YellowButton()
            button.title = day.title
            button.tag = day.rawValue
            button.addTarget(self, action: #selector(dayButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    @objc private func dayButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        if selectedIndexes.contains(index) {
            selectedIndexes.remove(index)
        } else {
            selectedIndexes.insert(index)
        }
        sender.isSelected = selectedIndexes.contains(index)
    }

    private func saveSelection() {
        let array = Array(selectedIndexes).sorted()
        print(array)
        UserDefaults.standard.set(array, forKey: "selectedWeekdays")
    }

    private func loadSelection() {
        let array = UserDefaults.standard.array(forKey: "selectedWeekdays") as? [Int] ?? []
        selectedIndexes = Set(array)

        // Обновить UI-кнопки
        for case let button as YellowButton in stackView.arrangedSubviews {
            let isSelected = selectedIndexes.contains(button.tag)
            button.isSelected = isSelected
        }
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 32),
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),

            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}
