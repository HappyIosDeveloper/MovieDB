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
enum CornerRadius: CGFloat {
    case none = 0
    case large = 15
    case regular = 10
    case small = 5
    case round = -1
    case superLarge = 25
    case massiveLarge = 60
}
