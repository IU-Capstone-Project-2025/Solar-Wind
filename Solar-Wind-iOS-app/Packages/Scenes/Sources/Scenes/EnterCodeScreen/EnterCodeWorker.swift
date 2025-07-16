//
//  EnterCodeWorker.swift
//  Scenes
//
//  Created by Даша Николаева on 13.07.2025.
//

import Core
import Foundation

final class EnterCodeWorker {
    func enterCode(code: String, completion: EnterCode.Completion?) {
        let request = EnterCodeRequest(code: code)
        APIClient.shared.send(request) { result in
            switch result {
            case .success(let response):
                UserDefaults.standard.set(response.id, forKey: "id")
                UserDefaults.standard.set(response.token, forKey: "token")
                let mappedResponse = EnterCode.Next.Response(model: .init(id: response.id, token: response.token))
                completion?(.success(mappedResponse))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
