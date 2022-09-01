//
//  Repository.swift
//  Countries Selection App
//
//  Created by Ahmadreza on 7/10/22.
//

import Foundation

class Repository {
    
    static let shared = Repository()
    private let apiKey = "33d79fc07f9fe5adde08ea3d05557e55"
    private let baseURL = "https://api.themoviedb.org/3/"
    let imagesBaseURL = "https://image.tmdb.org/t/p/original/"
    private let repositoryDataDeadlineInSeconds: Double = 300

    private init() {}
    
    func searchMovie(name: String, pageNumber: Int, comple: @escaping (Result<SearchMovieResponse, WebService.RequestError>)->()) {
        let url = URL(string: baseURL + "search/movie?api_key=\(apiKey)&language=en-US&query=\(name)&page=\(pageNumber)&include_adult=false".encode())!
        getLocalDataIfPossible(for: url.absoluteString, withType: SearchMovieResponse.self) { [weak self] result in
            switch result {
            case .success(_):
                comple(result)
            case .failure(_):
                self?.requestAndSaveAndContinue(for: url, withType: SearchMovieResponse.self, comple: comple)
            }
        }
    }
}

// MARK: - Base Functionality
extension Repository {
    
    private func requestAndSaveAndContinue<T:Decodable>(for url: URL, withType: T.Type, comple: @escaping (Result<T, WebService.RequestError>)->()) {
        WebService.shared.searchMovie(url: url) { response in
            switch response {
            case .success(let data):
                let convertedData = try? JSONEncoder().encode(data)
                UserDefaults.standard.set(convertedData, forKey: url.absoluteString)   // MARK: Saving request data
                UserDefaults.standard.set(Date(), forKey: url.absoluteString + "date") // MARK: Saving request time
                comple(.success(data as! T))
            case .failure(let error):
                comple(.failure(error))
            }
        }
    }
    
    private func getLocalDataIfPossible<T:Decodable>(for requestName: String, withType: T.Type, comple: @escaping (Result<T, WebService.RequestError>)->()) {
        if let savedDate = UserDefaults.standard.object(forKey: requestName + "date") as? Date {
            if savedDate > Date().addingTimeInterval(-repositoryDataDeadlineInSeconds) {
                if let data = UserDefaults.standard.data(forKey: requestName) {
                    if let data = try? JSONDecoder().decode(withType, from: data) {
                        comple(.success(data))
                    } else {
                        comple(.failure(.repositoryIssue))
                    }
                } else {
                    comple(.failure(.repositoryIssue))
                }
            } else {
                comple(.failure(.repositoryIssue))
            }
        } else {
            comple(.failure(.repositoryIssue))
        }
    }
}
