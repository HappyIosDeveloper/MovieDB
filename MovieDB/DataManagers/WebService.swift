//
//  WebService.swift
//  Countries Selection App
//
//  Created by Ahmadreza on 12/30/21.
//

import Foundation

class WebService {
    
    enum HTTPMethod: String { case get, post, put }
    enum RequestError: Error { case parsingIssue, wrongResponse, unknown, repositoryIssue }

    static let shared = WebService()
    
    private init () {}
    
    func searchMovie(url: URL, comple: @escaping (Result<SearchMovieResponse, RequestError>)->()) {
        baseRequest(url: url, method: .get, responseType: SearchMovieResponse.self, comple: comple)
    }
}

// MARK: - Base API Call Function
extension WebService {
    
    private func baseRequest<T:Decodable>(url: URL, method: HTTPMethod, responseType: T.Type, comple: @escaping (Result<T, RequestError>)->()) {
        print("*** \(method.rawValue) url: \(url.absoluteString)")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            if error == nil {
                do {
                    if let jsonString = String(data: data, encoding: .utf8) {
                       print("*** response json:\n" + jsonString + "\n\n")
                    }
                    let parsedResponse = try JSONDecoder().decode(responseType.self, from: data)
                    comple(.success(parsedResponse))
                } catch {
                    print("WebService getRequest error 1: " + error.localizedDescription)
                    comple(.failure(.parsingIssue))
                }
            } else {
                print("WebService getRequest error 2: " + error.debugDescription)
                comple(.failure(.wrongResponse))
            }
        }).resume()
    }
}
