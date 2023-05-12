//
//  LocalRepository.swift
//  MovieDB
//
//  Created by Ahmadreza on 5/12/23.
//

import Foundation

class LocalRepository {
    
    static let shared = LocalRepository()
    private let repositoryDataDeadlineInSeconds: Double = 300
    
    private init() {}
}

// MARK: - Public Functionality
extension LocalRepository {
    
    func saveRequest<T:Encodable>(for url: URL, withType: T.Type, data: T) {
        let encodedData = try? JSONEncoder().encode(data)
        UserDefaults.standard.set(encodedData, forKey: url.absoluteString)   // MARK: Saving request data
        UserDefaults.standard.set(Date(), forKey: url.absoluteString + "date") // MARK: Saving request time
    }
    
    func loadRequest<T:Decodable>(for requestName: String, withType: T.Type, completion: @escaping (Result<T, WebService.RequestError>)->()) {
        if let savedDate = UserDefaults.standard.object(forKey: requestName + "date") as? Date {
            if savedDate > Date().addingTimeInterval(-repositoryDataDeadlineInSeconds) {
                if let data = UserDefaults.standard.data(forKey: requestName) {
                    if let data = try? JSONDecoder().decode(withType, from: data) {
                        completion(.success(data))
                    } else {
                        completion(.failure(.repositoryIssue))
                    }
                } else {
                    completion(.failure(.repositoryIssue))
                }
            } else {
                completion(.failure(.repositoryIssue))
            }
        } else {
            completion(.failure(.repositoryIssue))
        }
    }
}
