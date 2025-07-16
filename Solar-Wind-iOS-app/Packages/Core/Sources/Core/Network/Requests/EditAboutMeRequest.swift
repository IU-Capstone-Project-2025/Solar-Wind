//
//  EditAboutMeRequest.swift
//  Core
//
//  Created by Даша Николаева on 15.07.2025.
//

import Alamofire
import Foundation

public struct EditAboutMeRequest: APIRequest {
    public typealias Response = SaveAboutMeResponse
    public var method: HTTPMethod { .put }
    public var path: String { "profiles/api/me" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders?
    public var encoding: ParameterEncoding { JSONEncoding.default }
    
    public init(userDefaults: UserDefaults = .standard) {
        let username = userDefaults.string(forKey: "userName") ?? ""
        let description = userDefaults.string(forKey: "userAboutMe") ?? ""
        let cityId = userDefaults.integer(forKey: "selectedCityId")
        let sportId: [Int] = (userDefaults.array(forKey: "sports") as? [Int]) ?? [1]
        let days: [Int] = (userDefaults.array(forKey: "selectedWeekdays") as? [Int]) ?? [1]
        
        self.parameters = [
            "id": userDefaults.string(forKey: "id") ?? "",
            "telegramId": userDefaults.string(forKey: "id") ?? "",
            "username": username,
            "firstName": "firstName",
            "lastName": "lastName",
            "description": description,
            "age": "2025-07-11",
            "gender": "male",
            "preferredGender": "male",
            "cityId": cityId,
            "preferredGymTime": days,
            "sportId": sportId
        ]
        self.headers = [
            "Authorize": "\(userDefaults.string(forKey: "token") ?? "")",
            "Authorization-telegram-id": "\(userDefaults.string(forKey: "id") ?? "")"
        ]
    }
    
}
