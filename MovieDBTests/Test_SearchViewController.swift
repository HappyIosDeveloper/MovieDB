//
//  Test_SearchViewController.swift
//  MovieDBTests
//
//  Created by Alfredo on 8/25/22.
//

import XCTest
@testable import MovieDB

class Test_SearchViewController: XCTestCase {
    
    func getViewController()-> SearchViewController {
        let bundle = Bundle(for: SearchViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        return vc
    }
    
    func testNavigationBar() {
        let sut = getViewController()
        sut.view.layoutIfNeeded()
        XCTAssertNotNil(sut.navigationItem.title)
        XCTAssertEqual(sut.navigationItem.title, "search".localized)
    }
    
    func testSearchBar() {
        let sut = getViewController()
        sut.view.layoutIfNeeded()
        XCTAssertNotNil(sut.searchBar.placeholder)
        XCTAssertEqual(sut.searchBar.placeholder, "search_here".localized)
        XCTAssertNotNil(sut.searchBar.delegate)
        let vm = SearchViewModel()
        XCTAssertEqual(vm.searchString, "")
        vm.searchString = "ab"
        XCTAssertFalse(vm.isSearchTextValid())
        vm.searchString = "abc"
        XCTAssertTrue(vm.isSearchTextValid())
    }
    
    func testCollectionView() {
        // test delegation
        // test adding cells
    }
}
