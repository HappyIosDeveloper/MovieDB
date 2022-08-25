//
//  SearchViewController.swift
//  MovieDB
//
//  Created by Alfredo on 8/25/22.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

// MARK: - Setup Functions
extension SearchViewController {
    
    private func setupViews() {
        setupNavigationBar()
        setupSearchBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "search".localized
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "search_here".localized
    }
}

// MARK: - SearchBar Functions
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        setupSearchBarDirection(searchText: searchText)
        viewModel.searchString = searchText
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        setupSearchBarDirection(searchText: searchBar.text ?? "")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        setupSearchBarDirection(searchText: searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchAction()
    }
    
    func setupSearchBarDirection(searchText: String) {
        if searchBar.text?.isEmpty ?? true {
            searchBar.semanticContentAttribute = isLanguageRTL ? .forceRightToLeft : .forceLeftToRight
        } else {
            searchBar.semanticContentAttribute = searchText.constainsArabic ? .forceRightToLeft : .forceLeftToRight
        }
    }
}

// MARK: - CollectionView Functions
extension SearchViewController {
    
}
