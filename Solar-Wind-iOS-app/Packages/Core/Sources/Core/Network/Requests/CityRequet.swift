//
//  CityRequet.swift
//  Core
//
//  Created by Даша Николаева on 25.06.2025.
//

import Alamofire

public struct CityRequest: APIRequest {
    public typealias Response = [City]
    
    public var method: HTTPMethod { .get }
    public var path: String { "cities/pagination" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { URLEncoding.default }
    
    public init(page: Int, size: Int, searchText: String? = nil) {
        var params: [String: String] = [
            "page": "\(page)",
            "size": "\(size)"
        ]
        
        if let searchText = searchText, !searchText.isEmpty {
            params["search"] = searchText
        }
        
        self.parameters = params
    }
}

public struct City: Decodable, Sendable {
    public let id: Int
    public let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "cityName"
    }
}
