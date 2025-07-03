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
    public var path: String { "deckShuffle/api/create-deck" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { URLEncoding.default }
    
    public init(userDefaults: UserDefaults = .standard) {
        let id = userDefaults.integer(forKey: "userId")
        print(id)
        var params: [String: String] = [
            "id": "\(id)",
        ]
        
        self.parameters = params
    }
}

public struct User: Decodable, Sendable {
    public let id: Int
    public let username: String
    public let description: String
    public let cityName: String
    let preferredGymTime: [Int]
    public let sportName: [String]
}
