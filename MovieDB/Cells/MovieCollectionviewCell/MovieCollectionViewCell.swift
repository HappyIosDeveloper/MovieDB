//
//  MovieCollectionViewCell.swift
//  MovieDB
//
//  Created by Alfredo on 8/26/22.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var cellSize: CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            let width = UIScreen.main.bounds.width / 3.5
            return CGSize(width: width, height: width / 2)
        } else {
            let width = screenWidth - 40
            return CGSize(width: width, height: width / 2)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
}

// MARK: Setup Functions
extension MovieCollectionViewCell {
    
    private func setupCell() {
        parentView.dropShadowAndCornerRadius(.large, shadowOpacity: 0.2)
        backgroundImageView.roundUp(.large)
        titleLabel.textColor = .white
        parentView.bringSubviewToFront(titleLabel)
        parentView.backgroundColor = .lightGray
    }
    
    func setup(with film: SearchMovieResponseResult) {
        titleLabel.text = film.title ?? "_"
        titleLabel.textAlignment = titleLabel.text!.containsArabic ? .right : .left
        if let url = URL(string: Repository.shared.imagesBaseURL + (film.posterPath ?? "?")) {
            loadImage(with: url)
        } else {
            showErrorImage()
        }
    }
    
    private func loadImage(with url: URL) {
        backgroundImageView.showActivityIndicator()
        backgroundImageView.sd_setImage(with: url) { [weak self] image, error, type, url in
            if image != nil {
                self?.backgroundImageView.contentMode = .scaleAspectFill
            } else {
                self?.showErrorImage()
            }
        }
        // MARK: Uncomment to load images without a library
        // backgroundImageView.loadImage(from: Repository.shared.imagesBaseURL + (film.posterPath ?? "?"))
    }
    
    private func showErrorImage() {
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.image = UIImage(named: "no-image")
    }
}
