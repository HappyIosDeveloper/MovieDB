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
    
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewModel()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        viewModel.reloadCollectionView()
    }
}

// MARK: - Setup Functions
extension SearchViewController {
    
    private func setupViews() {
        setupNavigationBar()
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupViewModel() {
        viewModel = SearchViewModel() {
            self.reloadCollectionView()
        }
        viewModel.films = []
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "search".localized
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "search_here".localized
        searchBar.becomeFirstResponder()
    }
    
    private func setupCollectionView() {
        let space: CGFloat = 16
        let cellID = MovieCollectionViewCell.identifier
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
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
    
    private func setupCollectionViewBackground(shouldShowBackground: Bool) {
        let dimension = screenWidth / 4
        let backView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: dimension, height: dimension)))
        backView.image = UIImage(named: "nodata-found")
        backView.contentMode = .scaleAspectFit
        collectionView.backgroundView = shouldShowBackground ? backView : nil
    }
    
    private func reloadCollectionView() {
        collectionView.reloadData()
        setupCollectionViewBackground(shouldShowBackground: viewModel.films.isEmpty)
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
            searchBar.semanticContentAttribute = searchText.containsArabic ? .forceRightToLeft : .forceLeftToRight
        }
    }
}

// MARK: - CollectionView Functions
extension SearchViewController: CollectionViewDelegates {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.setup(with: viewModel.films[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return MovieCollectionViewCell.cellSize
    }
}
