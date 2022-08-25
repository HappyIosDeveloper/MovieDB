//
//  Test_SearchViewController.swift
//  MovieDBTests
//
//  Created by Alfredo on 8/25/22.
//

import XCTest
@testable import MovieDB

class Test_SearchViewController: XCTestCase {
    
    func getViewController()-> UIViewController {
        let bundle = Bundle(for: SearchViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController")
        return vc
    }
    
    func testNavigationBar() {
        let sut = getViewController()
        sut.view.layoutIfNeeded()
        XCTAssertEqual(sut.navigationController?.title, "search".localized)
    }
    
    func testSearchBar() {
        // test placeholder
        // test delegation
    }
    
    func testCollectionView() {
        // test delegation
        // test adding cells
    }
}
