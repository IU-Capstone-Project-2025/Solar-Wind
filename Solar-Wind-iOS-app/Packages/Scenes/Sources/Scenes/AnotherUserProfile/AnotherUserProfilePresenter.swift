//
//  AnotherUserProfilePresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 01.07.2025.
//

final class AnotherUserProfilePresenter {
    let view: AnotherUserProfileViewConrtroller?
    
    init(view: AnotherUserProfileViewConrtroller) {
        self.view = view
    }
    
    let daysMapping: [Int: String] = [
        0: "Mon",
        1: "Tue",
        2: "Wed",
        3: "Thu",
        4: "Fri",
        5: "Sat",
        6: "Sun",
    ]
    
    @MainActor func present(_ response: AnotherUserProfile.Fetch.Response) {
        guard let model = response.model else { return }
        var days: [String] = []
        for dayId in model.days {
            if let day = daysMapping[dayId] { days.append(day) }
        }
        let viewModel = AnotherUserProfile.RootViewModel(username: model.username, city: model.city, sports: model.sports, about: model.about, days: days)
        view?.display(AnotherUserProfile.Fetch.ViewModel(root: viewModel))
    }

}
