//
//  LikeRequest.swift
//  Core
//
//  Created by Даша Николаева on 15.07.2025.
//

import Alamofire
import Foundation

public struct LikeRequest: APIRequest {
    public typealias Response = LikeResponse
    
    public var method: HTTPMethod { .post }
    public var path: String { "notifications" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders?
    public var encoding: ParameterEncoding { URLEncoding.default }
    
    public init(userDefaults: UserDefaults = .standard, user2: Int) {
        let id = userDefaults.string(forKey: "id")
        self.headers = [
            "Authorize": "\(userDefaults.string(forKey: "token") ?? "")",
            "Authorization-telegram-id": "\(id ?? "")"
        ]
        self.parameters = [
            "user1": id,
            "user2": user2
        ]
    }
}

public struct LikeResponse: Decodable, Sendable { }
