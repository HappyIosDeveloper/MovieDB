//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by Alfredo on 8/25/22.
//

import UIKit

class SearchViewModel {
    
    var searchString = ""
    var reloadCollectionView: (()->())?
    var films = ["a", "b", "c"] {
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
        cell.backgroundColor = [UIColor.red, .blue, .green, .gray, .white].randomElement()!
        return cell
    }
    
    func getCellSize()-> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            let width = screenWidth / 3.5
            return CGSize(width: width, height: width / 2)
        } else {
            let width = screenWidth - 40
            return CGSize(width: screenWidth, height: width / 2)
        }
    }
}

// MARK: - API Calls
extension SearchViewModel {
    
    func searchRequest() {
        print("Search API call")
    }
}
