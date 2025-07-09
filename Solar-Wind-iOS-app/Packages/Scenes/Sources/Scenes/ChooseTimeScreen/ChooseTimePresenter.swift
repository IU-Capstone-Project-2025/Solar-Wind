//
//  ChooseTimePresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 16.06.2025.
//

final class ChooseTimePresenter {
    weak var view: ChooseTimeViewController?
    
    @MainActor func present(_ response: ChooseTime.Next.Response) {
        view?.display(ChooseTime.Next.ViewModel())
    }
}
