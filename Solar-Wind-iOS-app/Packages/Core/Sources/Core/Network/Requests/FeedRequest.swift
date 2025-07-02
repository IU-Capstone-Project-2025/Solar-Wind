//
//  FeedRequest.swift
//  Core
//
//  Created by Даша Николаева on 27.06.2025.
//

import Alamofire
import Foundation

public struct FeedRequest: APIRequest {
    public typealias Response = [User]
    
    public var method: HTTPMethod { .get }
    public var path: String { "create-deck" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { URLEncoding.default }
    
    public init(userDefaults: UserDefaults = .standard) {
        let id = userDefaults.integer(forKey: "id")
        var params: [String: String] = [
            "id": "\(id)",
        ]
        
        self.parameters = params
    }
}

public struct User: Decodable, Sendable {
    public let id: Int
    let telegramId: String?
    public let username: String
    let firstName: String
    let lastName: String
    public let description: String
    let age: Int
    let gender: String
    let verified: Bool
    let preferredGender: String
    public let cityId: Int
    let preferredGymTime: [Int]
    public let sportId: [Int]
}
