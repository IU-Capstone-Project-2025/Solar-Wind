//
//  MyProfileWorker.swift
//  Scenes
//
//  Created by Даша Николаева on 09.07.2025.
//

import Foundation
import Core
import CommonModels

final class MyProfileWorker {
    func fetch(completion: MyProfile.MyProfileCompletion?) {
        let id = UserDefaults.standard.integer(forKey: "userId")
        let request = ProfileRequest(id: id)
        print(request)
        APIClient.shared.send(request) { result in
            switch result {
            case .success(let user):
                let mappedResult = MyProfile.Fetch.Response(model: .init(username: user.username, city: user.cityName, sports: user.sportName, about: user.description, days: user.preferredGymTime))
                completion?(.success(mappedResult))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
