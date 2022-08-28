//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by Alfredo on 8/25/22.
//

import UIKit

class SearchViewModel {
    
    var currentPage = 1
    var searchString = ""
    var reloadCollectionView: (()->())?
    var films: [SearchMovieResponseResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadCollectionView?()
            }
        }
    }
    
    func bind(reloadCollectionView: (()->())?) {
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
            
        }
    }
}

// MARK: - CollectionView Functions
extension SearchViewModel {
    
    func getCellsCount()-> Int {
        return films.count 
    }
    
    func getCell(collectionView: UICollectionView, indexPath: IndexPath)-> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.setup(with: films[indexPath.row])
        return cell
    }
    
    func getCellSize()-> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            let width = UIScreen.main.bounds.width / 3.5
            return CGSize(width: width, height: width / 2)
        } else {
            let width = screenWidth - 40
            return CGSize(width: width, height: width / 2)
        }
    }
}

// MARK: - API Calls
extension SearchViewModel {
    
    func searchRequest() {
        Repository.shared.searchMovie(name: searchString, pageNumber: currentPage) { response in
            switch response {
            case .success(let data):
                if let films = data.results {
                    self.films = films
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
