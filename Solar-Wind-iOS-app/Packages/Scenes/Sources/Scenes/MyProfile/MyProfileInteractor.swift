//
//  MyProfileInteractor.swift
//  Scenes
//
//  Created by Даша Николаева on 04.07.2025.
//

import Foundation

final class MyProfileInteractor {
    private let presenter: MyProfilePresenter
    
    init(presenter: MyProfilePresenter) {
        self.presenter = presenter
    }
    
    @MainActor func logout() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
            UserDefaults.standard.synchronize()
        }
        presenter.logout()
    }
}
