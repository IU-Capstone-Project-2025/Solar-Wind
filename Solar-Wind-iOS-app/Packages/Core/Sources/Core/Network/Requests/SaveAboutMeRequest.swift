//
//  SaveAboutMeRequest.swift
//  Core
//
//  Created by Даша Николаева on 27.06.2025.
//

import Alamofire
import Foundation

public struct SaveAboutMeRequest: APIRequest {
    public typealias Response = SaveAboutMeResponse
    public var method: HTTPMethod { .post }
    public var path: String { "me" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { JSONEncoding.default }
    
    public init(userDefaults: UserDefaults = .standard) {
        let username = userDefaults.string(forKey: "userName") ?? ""
        let description = userDefaults.string(forKey: "userAboutMe") ?? ""
        let cityId = userDefaults.integer(forKey: "selectedCityId")
        let sportId: [Int] = (userDefaults.array(forKey: "sports") as? [Int]) ?? [1]
        let days: [Int] = (userDefaults.array(forKey: "selectedWeekdays") as? [Int]) ?? [1]
        
        self.parameters = [
            "username": username,
            "firstName": "firstName",
            "lastName": "lastName",
            "description": description,
            "age": 1,
            "gender": "male",
            "preferredGender": "male",
            "cityId": cityId,
            "preferredGymTime": days,
            "sportId": sportId
        ]
    }
}

public struct SaveAboutMeResponse: Decodable, Sendable {
    public let id: Int
}
