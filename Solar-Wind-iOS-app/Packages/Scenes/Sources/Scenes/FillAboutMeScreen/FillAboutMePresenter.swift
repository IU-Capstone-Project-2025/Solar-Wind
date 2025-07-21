//
//  FillAboutMePresenter.swift
//  Scenes
//
//  Created by Даша Николаева on 21.06.2025.
//

final class FillAboutMePresenter {
    weak var view: FillAboutMeViewController?
    
    @MainActor func present(_ response: FillAboutMe.Next.Response) {
        view?.display(FillAboutMe.Next.ViewModel())
    }
}
