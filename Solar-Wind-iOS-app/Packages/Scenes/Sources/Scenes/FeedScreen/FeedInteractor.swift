//
//  FeedInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 25.06.2025.
//

import Core
import Foundation

final class FeedInteractor {
    private let presenter: FeedPresenter
    
    init(presenter: FeedPresenter) {
        self.presenter = presenter
    }
    
    @MainActor func loadInitialData() {
        // Заглушечные данные
//        let mockUsers = [
//            Feed.RootViewModel.User(
//                id: 1,
//                name: "Oleg",
//                city: "Иннополис",
//                tags: ["Борьба"],
//                description: "Ищу друзей для развития ударов"
//            ),
//            Feed.RootViewModel.User(
//                id: 2,
//                name: "Изабелла Иванова",
//                city: "Санкт-Петербург",
//                tags: ["Футбол"],
//                description: "Хочу разукрасиить свои будни совместными играми в футбол"
//            ),
//            Feed.RootViewModel.User(
//                id: 3,
//                name: "Маша",
//                city: "Казань",
//                tags: ["Бокс"],
//                description: "Погнали драться"
//            ),
//            Feed.RootViewModel.User(
//                id: 3,
//                name: "Кто-то",
//                city: "Казань",
//                tags: ["Бег"],
//                description: "обожаю бег, бегаю уже 10 лет"
//            )
//        ]
//        
//        presenter.present(users: mockUsers)
        let request = FeedRequest()
        APIClient.shared.send(request) { result in
            switch result {
            case .success(let response):
//                let mappedResult = result.map { users in
//                    users.map { Feed.RootViewModel.User(id: $0.id, name: $0.username, city: $0.city, tags: $0.sports, description: $0.description) }
//                }
//                presenter.present(users: mappedResult)
                return
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @MainActor func request(_ request: Feed.Select.Request) {
        self.presenter.present(Feed.Select.Response(), id: request.userId)
    }
}
