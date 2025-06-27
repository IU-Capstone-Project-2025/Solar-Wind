//
//  FeedInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

final class FeedInteractor {
    private let presenter: FeedPresenter
    
    init(presenter: FeedPresenter) {
        self.presenter = presenter
    }
    
    @MainActor func loadInitialData() {
        // Заглушечные данные
        let mockUsers = [
            Feed.RootViewModel.User(
                id: 1,
                name: "Oleg",
                city: "Иннополис",
                tags: ["Борьба"],
                description: "Ищу друзей для развития ударов"
            ),
            Feed.RootViewModel.User(
                id: 2,
                name: "Изабелла Иванова",
                city: "Санкт-Петербург",
                tags: ["Футбол"],
                description: "Хочу разукрасиить свои будни совместными играми в футбол"
            ),
            Feed.RootViewModel.User(
                id: 3,
                name: "Маша",
                city: "Казань",
                tags: ["Бокс"],
                description: "Погнали драться"
            ),
            Feed.RootViewModel.User(
                id: 3,
                name: "Кто-то",
                city: "Казань",
                tags: ["Бег"],
                description: "обожаю бег, бегаю уже 10 лет"
            )
        ]
        
        presenter.present(users: mockUsers)
    }
}
