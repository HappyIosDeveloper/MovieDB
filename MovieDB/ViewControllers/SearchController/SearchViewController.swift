//
//  SearchViewController.swift
//  MovieDB
//
//  Created by Alfredo on 8/25/22.
//

import UIKit

class SearchViewController: UIViewController {

    private var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
    }
}

// MARK: - Setup Functions
extension SearchViewController {
    
    func setupViews() {
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "search".localized
    }
}

// MARK: - SearchBar Functions
extension SearchViewController {
    
}

// MARK: - CollectionView Functions
extension SearchViewController {
    
}
