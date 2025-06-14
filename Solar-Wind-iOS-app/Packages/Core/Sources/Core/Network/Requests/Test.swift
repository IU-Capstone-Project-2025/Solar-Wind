//
//  Test.swift
//  Core
//
//  Created by Даша Николаева on 14.06.2025.
//

import Alamofire

public struct TestRequest: APIRequest {
    public typealias Response = Test
    
    public var method: HTTPMethod { .get }
    public var path: String { "meowfacts.herokuapp.com" }
    public var parameters: Parameters? { nil }
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { URLEncoding.default }
    
    public init() {}
}

public struct Test: Decodable, Sendable {
    let data: [String]
}
