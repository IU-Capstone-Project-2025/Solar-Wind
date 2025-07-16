//
//  EnterCodeRequest.swift
//  Core
//
//  Created by Даша Николаева on 13.07.2025.
//

import Alamofire

public struct EnterCodeRequest: APIRequest {
    public typealias Response = Auth
    
    public var method: HTTPMethod { .get }
    public var path: String { "profiles/auth/telegram/custom-auth" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { URLEncoding.default }
    
    public init(code: String) {
        var params: [String: String] = [
            "code": "\(code)",
        ]
        self.parameters = params
    }
}

public struct Auth: Decodable, Sendable {
    public let id: String
    public let token: String
}
