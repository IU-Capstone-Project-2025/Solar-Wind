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
    
    @MainActor func present(_ response: AnotherUserProfile.Fetch.Response) {
        guard let model = response.model else { return }
        let viewModel = AnotherUserProfile.RootViewModel(username: model.username, city: model.city, sports: model.sports)
        view?.display(AnotherUserProfile.Fetch.ViewModel(root: viewModel))
    }

}
