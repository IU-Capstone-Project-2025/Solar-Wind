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
}
