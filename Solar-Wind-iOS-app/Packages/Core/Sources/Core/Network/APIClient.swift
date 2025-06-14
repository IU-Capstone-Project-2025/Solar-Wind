//
//  APIClient.swift
//  Core
//
//  Created by Даша Николаева on 14.06.2025.
//

import Alamofire
import Combine
import CommonModels

public final class APIClient: @unchecked Sendable {
    public static let shared = APIClient()
    private let session: Session
    
    private init(session: Session = .default) {
        self.session = session
    }
    
    public func send<T: APIRequest>(
        _ request: T,
        completion: @Sendable @escaping (Result<T.Response, AppError>) -> Void
    ) {
        let url = "https://" + request.path
        
        session.request(
            url,
            method: request.method,
            parameters: request.parameters,
            encoding: request.encoding,
            headers: request.headers
        )
        .validate()
        .responseDecodable(of: T.Response.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(AppError.from(error)))
            }
        }
    }
}
