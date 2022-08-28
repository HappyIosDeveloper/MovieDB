//
//  UIViewControllerExtensions.swift
//  MovieDB
//
//  Created by Alfredo on 8/25/22.
//

import UIKit

extension UIViewController {

    var isLanguageRTL: Bool {
        guard let language = Locale.current.languageCode else { return false }
        let direction = Locale.characterDirection(forLanguage: language)
        return direction == .rightToLeft
    }
}
