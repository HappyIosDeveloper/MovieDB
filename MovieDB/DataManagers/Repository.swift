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
    let imagesBaseURL = "https://image.tmdb.org/t/p/original"

    private init() {}
    
}

// MARK: - API Calls
extension Repository {
    
    func searchMovie(name: String, pageNumber: Int, completion: @escaping (Result<SearchMovieResponse, WebService.RequestError>)->()) {
        let url = URL(string: baseURL + "search/movie?api_key=\(apiKey)&language=en-US&query=\(name)&page=\(pageNumber)&include_adult=false".encode())!
        LocalRepository.shared.loadRequest(for: url.absoluteString, withType: SearchMovieResponse.self) { result in
            switch result {
            case .success(_):
                completion(result)
            case .failure(_):
                WebService.shared.searchMovie(url: url) { result in
                    switch result {
                    case .success(let data):
                        LocalRepository.shared.saveRequest(for: url, withType: SearchMovieResponse.self, data: data)
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
