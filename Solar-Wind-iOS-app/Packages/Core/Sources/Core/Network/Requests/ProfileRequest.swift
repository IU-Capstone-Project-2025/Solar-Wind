//
//  ProfileRequest.swift
//  Core
//
//  Created by Даша Николаева on 01.07.2025.
//

import Alamofire

public struct ProfileRequest: APIRequest {
    public typealias Response = [City]
    
    public var method: HTTPMethod { .get }
    public var path: String { "" }
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
    public let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "cityName"
    }
}
