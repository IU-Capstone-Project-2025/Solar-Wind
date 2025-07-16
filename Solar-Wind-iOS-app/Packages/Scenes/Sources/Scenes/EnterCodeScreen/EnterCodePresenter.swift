//
//  EnterCodePresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 13.07.2025.
//

final class EnterCodePresenter {
    weak var view: EnterCodeViewController?
    @MainActor func present(_ response: EnterCode.Next.Response) {
        view?.present(EnterCode.Next.ViewModel())
    }
}
