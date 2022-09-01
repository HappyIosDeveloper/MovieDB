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
    
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor.clear.cgColor, UIColor.gray.cgColor]
        l.startPoint = CGPoint(x: 0.5, y: 0.5)
        l.endPoint = CGPoint(x: 0.5, y: 2)
        l.cornerRadius = 16
        layer.insertSublayer(l, at: 0)
        return l
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }

    private func setupCell() {
        parentView.dropShadowAndCornerRadius(.large, shadowOpacity: 0.2)
        backgroundImageView.roundUp(.large)
        parentView.layer.sublayers?.append(gradientLayer)
        titleLabel.textColor = .white
        parentView.bringSubviewToFront(titleLabel)
    }
    
    func setup(with film: SearchMovieResponseResult) {
        titleLabel.text = film.title ?? "_"
        titleLabel.textAlignment = titleLabel.text!.containsArabic ? .right : .left
        backgroundImageView.showActivityIndicator()
        backgroundImageView.sd_setImage(with: URL(string: Repository.shared.imagesBaseURL + (film.posterPath ?? "?"))) { [weak self] image, error, type, url in
            if error != nil {
                self?.backgroundImageView.contentMode = .scaleAspectFit
                self?.backgroundImageView.image = UIImage(named: "no-image")
            } else {
                self?.backgroundImageView.contentMode = .scaleAspectFill
            }
        }
        // MARK: To load images without a library
        // backgroundImageView.loadImage(from: Repository.shared.imagesBaseURL + (film.posterPath ?? "?"))
    }
}
