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
         return Bundle.main.localizedString(forKey: self, value: nil, table: "Localizable")
     }
    
    var containsArabic: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "(?s).*\\p{Arabic}.*")
        return predicate.evaluate(with: self)
    }
    
    func encode()-> String {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "?"
    }
}
