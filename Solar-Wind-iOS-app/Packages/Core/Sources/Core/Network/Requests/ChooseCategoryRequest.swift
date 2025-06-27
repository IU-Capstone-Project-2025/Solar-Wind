//
//  ChooseCategoryRequest.swift
//  Core
//
//  Created by Даша Николаева on 25.06.2025.
//

import Alamofire

import Alamofire

public struct CategoryRequest: APIRequest {
    public typealias Response = [Category]

    public var method: HTTPMethod { .get }
    public var path: String { "sports/pagination" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { URLEncoding.default }

    public init(page: Int, size: Int) {
        self.parameters = [
            "page": "\(page)",
            "size": "\(size)"
        ]
    }
}

public struct Category: Decodable, Sendable {
    public let id: Int
    public let name: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name = "sportType"
    }
}
