//
//  ProfileRequest.swift
//  Core
//
//  Created by Даша Николаева on 01.07.2025.
//

import Alamofire
import Foundation

public struct ProfileRequest: APIRequest {
    public typealias Response = Profile
    
    public var method: HTTPMethod { .get }
    public var path: String { "profiles/api/me" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders?
    public var encoding: ParameterEncoding { URLEncoding.default }
    
    public init(id: Int) {
        self.headers = [
            "Authorize": "\(UserDefaults.standard.string(forKey: "token") ?? "")",
            "Authorization-telegram-id": "\(UserDefaults.standard.string(forKey: "id") ?? "")"
        ]
    }
}

public struct Profile: Decodable, Sendable {
    public let id: Int
    public let username: String
    public let description: String
    public let cityName: String
    public let preferredGymTime: [Int]
    public let sportName: [String]
}
