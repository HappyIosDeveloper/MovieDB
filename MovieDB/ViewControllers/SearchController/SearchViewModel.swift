//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by Alfredo on 8/25/22.
//

import Foundation

class SearchViewModel {
    
    var currentPage = 1
    var reloadCollectionView: (()->())
    var searchString = "" {
        didSet {
            searchAction()
        }
    }
    var films: [SearchMovieResponseResult] = [] {
        didSet {
            reloadCollectionView()
        }
    }
    
    init(reloadCollectionView: (@escaping () -> Void)) {
        self.reloadCollectionView = reloadCollectionView
    }
}

// MARK: - Actions
extension SearchViewModel {
    
    func isSearchTextValid()-> Bool {
        return searchString.count > 2
    }
    
    func searchAction() {
        if isSearchTextValid() {
            searchRequest()
        } else {
            films = []
        }
    }
}

// MARK: - API Calls
extension SearchViewModel {
    
    func searchRequest() {
        Repository.shared.searchMovie(name: searchString, pageNumber: currentPage) { [weak self] response in
            switch response {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.films = data.results ?? []
                }
            case .failure(let error):
                switch error {
                case .parsingIssue:
                    print("parsingIssue")
                case .wrongResponse:
                    print("wrongResponse")
                case .unknown:
                    print("unknown")
                case .repositoryIssue:
                    print("repositoryIssue")
                }
            }
        }
    }
}
