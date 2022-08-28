//
//  GlobalVariables.swift
//  MovieDB
//
//  Created by Alfredo on 8/26/22.
//

import UIKit

typealias CollectionViewDelegates = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
var isLanguageRTL: Bool {
    guard let language = Locale.current.languageCode else { return false }
    let direction = Locale.characterDirection(forLanguage: language)
    return direction == .rightToLeft
}
