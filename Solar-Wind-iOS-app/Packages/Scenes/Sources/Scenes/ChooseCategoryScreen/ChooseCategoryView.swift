//
//  ChooseCategoryView.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

import UIKit
import CommonUI

final class ChooseCategoryView: View {
    enum Action {
        case next
        case selected(Int)
        case add
    }

    var actionHandler: (Action) -> Void = { _ in }

    private typealias DataSource = UITableViewDiffableDataSource<ChooseCategory.RootViewModel.Section, ChooseCategory.Category>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ChooseCategory.RootViewModel.Section, ChooseCategory.Category>

    var selectedCategories: [ChooseCategory.Category] = [] {
        didSet { updateTags(selectedCategories) }
    }

    private var allItems: [ChooseCategory.Category] = []

    var viewModel: ChooseCategory.RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            var snapshot = Snapshot()
            snapshot.appendSections(viewModel.sections)
            viewModel.sections.forEach { section in
                switch section {
                case .items(let items):
                    allItems = items
                    snapshot.appendItems(items, toSection: section)
                }
            }
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose your training categories"
        label.font = .size20Medium
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var header = addGradientHeader(text: "Before you start...")

    private lazy var searchView: SearchView = {
        let view = SearchView(placeholder: "Search...")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tagsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var tagsContainerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    private lazy var nextButton: UIButton = {
        let button = GradientButton()
        button.title = "Continue"
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.actionHandler(.next)
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var dataSource: DataSource = {
        let ds = DataSource(tableView: tableView) { [weak self] tableView, indexPath, item in
            guard let self else { return nil }
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.name
            cell.accessoryType = selectedCategories.contains(item) ? .checkmark : .none
            return cell
        }
        return ds
    }()

    override func setupContent() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(searchView)
        addSubview(tagsScrollView)
        tagsScrollView.addSubview(tagsContainerView)
        addSubview(tableView)
        addSubview(nextButton)
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),

            searchView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchView.heightAnchor.constraint(equalToConstant: 45),

            tagsScrollView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 12),
            tagsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tagsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tagsScrollView.heightAnchor.constraint(equalToConstant: 32),

            tagsContainerView.topAnchor.constraint(equalTo: tagsScrollView.topAnchor),
            tagsContainerView.bottomAnchor.constraint(equalTo: tagsScrollView.bottomAnchor),
            tagsContainerView.leadingAnchor.constraint(equalTo: tagsScrollView.leadingAnchor),
            tagsContainerView.trailingAnchor.constraint(equalTo: tagsScrollView.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: tagsScrollView.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -12),

            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    private func updateTags(_ categories: [ChooseCategory.Category]) {
        tagsContainerView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for category in categories {
            let tag = TagView(text: category.name)
            tagsContainerView.addArrangedSubview(tag)
        }
    }
}

extension ChooseCategoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = dataSource.itemIdentifier(for: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        actionHandler(.selected(category.id))
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == tableView else { return }
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height * 1.5 {
            actionHandler(.add)
        }
    }
}
