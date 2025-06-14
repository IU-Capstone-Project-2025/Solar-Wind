//
//  AppError.swift
//  CommonModels
//
//  Created by Даша Николаева on 14.06.2025.
//

import Alamofire

public enum AppError: Error {
    case decodingError
    case networkError(_ code: Int)
    case unknown(_ detail: String)
}

public extension AppError {
    static func from(_ afError: AFError) -> AppError {
        if let responseCode = afError.responseCode {
            return .networkError(responseCode)
        }
        return .unknown(afError.localizedDescription)
    }
}
