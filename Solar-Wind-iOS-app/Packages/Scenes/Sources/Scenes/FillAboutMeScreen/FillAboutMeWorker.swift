//
//  FillAboutMeWorker.swift
//  Scenes
//
//  Created by Даша Николаева on 22.06.2025.
//

import Foundation
import Core

final class FillAboutMeWorker {
    func save(name: String, aboutMe: String, completion: FillAboutMe.FillAboutMeCompletion?) {
        UserDefaults.standard.setValue(name, forKey: "userName")
        UserDefaults.standard.setValue(aboutMe, forKey: "userAboutMe")
        let request = SaveAboutMeRequest(userDefaults: UserDefaults.standard)
        
        APIClient.shared.send(request) { result in
            switch result {
            case .success(let response):
                UserDefaults.standard.setValue(true, forKey: "authorized")
                completion?(.success(FillAboutMe.Next.Response()))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
