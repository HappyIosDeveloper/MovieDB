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
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
         super.willTransition(to: newCollection, with: coordinator)
        viewModel.reloadCollectionView?()
     }
}

// MARK: - Setup Functions
extension SearchViewController {
    
    private func setupViews() {
        setupNavigationBar()
        setupSearchBar()
        setupCollectionView()
        bindViewModel()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "search".localized
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "search_here".localized
    }
    
    private func setupCollectionView() {
        let space: CGFloat = 16
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        collectionView.keyboardDismissMode = .onDrag
    }
    
    private func bindViewModel() {
        viewModel.bind {
            self.collectionView.reloadData()
        }
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
        view.endEditing(true)
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
extension SearchViewController: CollectionViewDelegates {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCellsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.getCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.getCellSize()
    }
}
