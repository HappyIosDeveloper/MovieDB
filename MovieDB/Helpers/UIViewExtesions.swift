//
//  UIViewExtesions.swift
//  MovieDB
//
//  Created by Ahmadreza on 9/1/22.
//

import UIKit

extension UIView {
    
    func roundUp(_ value: CornerRadius) {
        DispatchQueue.main.async { [self] in
            if value == .round {
                layer.cornerRadius = bounds.height / 2
            } else {
                layer.cornerRadius = value.rawValue
            }
            layer.masksToBounds = true
        }
    }
    
    func dropShadowAndCornerRadius(_ value: CornerRadius, shadowOpacity: Float = 1.05) {
        roundUp(value)
        dropShadow(opacity: shadowOpacity)
    }
    
    func dropShadow(opacity:Float = 0.1) {
        DispatchQueue.main.async { [self] in
            layer.masksToBounds = false
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOpacity = opacity
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowRadius = 8
        }
    }
}
