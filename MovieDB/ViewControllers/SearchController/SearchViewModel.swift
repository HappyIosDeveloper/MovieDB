//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by Alfredo on 8/25/22.
//

import Foundation

class SearchViewModel {
    
    var searchString = ""
    
    func bind() {
        
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
            
        }
    }
}

// MARK: - API Calls
extension SearchViewModel {
    
    func searchRequest() {
        print("Search API call")
    }
}
