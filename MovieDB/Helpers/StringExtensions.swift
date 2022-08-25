//
//  StringExtensions.swift
//  MovieDB
//
//  Created by Alfredo on 8/25/22.
//

import Foundation

extension String {

     func localize(with arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
     }
            
     var localized: String {
         return Bundle.main.localizedString(forKey: self, value: nil, table: "StandardLocalizations")
     }
}
