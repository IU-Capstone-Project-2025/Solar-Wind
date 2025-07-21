//
//  CitySearchRequest.swift
//  Core
//
//  Created by Даша Николаева on 08.07.2025.
//

import Alamofire

public struct CitySearchRequest: APIRequest {
    public typealias Response = [City]
    
    public var method: HTTPMethod { .get }
    public var path: String { "profiles/api/cities/search" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { URLEncoding.default }
    
    public init(word: String) {
        var params: [String: String] = [
            "word": "\(word)",
        ]
        self.parameters = params
    }
}
