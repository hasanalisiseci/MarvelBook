//
//  APIService.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import Alamofire
import Foundation

class APIService {
    static let shared = APIService()

    private let baseURL = "https://gateway.marvel.com/v1/public"
    private let publicKey = "aa83b573d8c738346fe21a3060eb9d09"
    private let privateKey = "44f2b7527cba143e83a7bd2c146f93c1ca88f080"

    private init() {}

    private func createAuthParams() -> [String: String] {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(privateKey)\(publicKey)".MD5
        return [
            "ts": timestamp,
            "apikey": publicKey,
            "hash": hash,
        ]
    }

    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        let url = baseURL + endpoint.path
        var params = endpoint.params
        params.merge(createAuthParams()) { _, new in new }
        print("URL: \(url)")
        AF.request(url, parameters: params, requestModifier: { $0.timeoutInterval = .infinity })
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
