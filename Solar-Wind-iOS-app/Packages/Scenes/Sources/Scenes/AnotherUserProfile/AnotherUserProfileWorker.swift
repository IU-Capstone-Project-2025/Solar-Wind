//
//  AnotherUserProfileWorker.swift
//  Scenes
//
//  Created by Даша Николаева on 01.07.2025.
//

import Core
import Foundation

final class AnotherUserProfileWorker {
    func fetch(id: Int, completion: AnotherUserProfile.AnotherUserProfileCompletion?) {
        let request = ProfileRequest(id: id)
        APIClient.shared.send(request) { result in
            switch result {
            case .success(let user):
                let mappedResult = AnotherUserProfile.Fetch.Response(model: .init(username: user.username, city: user.cityName, sports: user.sportName, about: user.description, days: user.preferredGymTime))
                completion?(.success(mappedResult))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
