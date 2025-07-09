//
//  MyProfilePresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 04.07.2025.
//

class MyProfilePresenter {
    public weak var view: MyProfileViewController?
    
    @MainActor func logout() {
        view?.logout()
    }
    
    let daysMapping: [Int: String] = [
        1: "Mon",
        2: "Tue",
        3: "Wed",
        4: "Thu",
        5: "Fri",
        6: "Sat",
        7: "Sun",
    ]
    
    @MainActor func present(_ response: MyProfile.Fetch.Response) {
        guard let model = response.model else { return }
        var days: [String] = []
        for dayId in model.days {
            if let day = daysMapping[dayId] { days.append(day) }
        }
        let viewModel = MyProfile.RootViewModel(username: model.username, city: model.city, sports: model.sports, about: model.about, days: days)
        view?.display(MyProfile.Fetch.ViewModel(root: viewModel))
    }
}
