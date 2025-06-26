//
//  APIClient.swift
//  Core
//
//  Created by Даша Николаева on 14.06.2025.
//

import Alamofire
import Combine
import CommonModels
import Foundation

public final class APIClient: @unchecked Sendable {
    public static let shared = APIClient()
    private let session: Session
    private let responseQueue: DispatchQueue
    
    private init(session: Session = .default,
                responseQueue: DispatchQueue = .main) {
        self.session = session
        self.responseQueue = responseQueue
    }
    
    public func send<T: APIRequest>(
        _ request: T,
        completion: @escaping (Result<T.Response, AppError>) -> Void
    ) {
        let url = "http://10.91.58.117:8080/api/" + request.path
        
        session.request(
            url,
            method: request.method,
            parameters: request.parameters,
            encoding: request.encoding,
            headers: request.headers
        )
        .validate()
        .responseDecodable(of: T.Response.self) { [weak self] response in
            self?.responseQueue.async {
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(AppError.from(error)))
                }
            }
        }
    }
}
