//
//  UIImageViewExtensions.swift
//  MovieDB
//
//  Created by Ahmadreza on 9/1/22.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func showActivityIndicator() {
        sd_imageIndicator = SDWebImageActivityIndicator.large
        sd_imageIndicator?.indicatorView.tintColor = .gray
        sd_imageIndicator?.startAnimatingIndicator()
    }
    
    func loadImage(from urlString: String) {
        var isLoadingImageFailed = false
        defer {
            if isLoadingImageFailed {
                self.image = UIImage(named: "no-image")
            }
        }
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    isLoadingImageFailed = true
                    return
                }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            task.resume()
        } else {
            isLoadingImageFailed = true
        }
    }
}
