//
//  ChooseCategorySearchRequest.swift
//  Core
//
//  Created by Даша Николаева on 08.07.2025.
//

import Alamofire

public class ChooseCategorySearchRequest: APIRequest {
    public typealias Response = [Category]

    public var method: HTTPMethod { .get }
    public var path: String { "profiles/api/sports/search" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { URLEncoding.default }

    public init(word: String) {
        self.parameters = [
            "word": word
        ]
    }
}
