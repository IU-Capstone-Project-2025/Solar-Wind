//
//  ProfileRequest.swift
//  Core
//
//  Created by Даша Николаева on 01.07.2025.
//

import Alamofire

public struct ProfileRequest: APIRequest {
    public typealias Response = Profile
    
    public var method: HTTPMethod { .get }
    public var path: String { "profiles/api/me" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { URLEncoding.default }
    
    public init(id: Int) {
        var params: [String: String] = [
            "id": "\(id)"
        ]
        
        self.parameters = params
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
