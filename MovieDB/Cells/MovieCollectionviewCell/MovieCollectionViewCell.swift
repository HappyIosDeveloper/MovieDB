//
//  MovieCollectionViewCell.swift
//  MovieDB
//
//  Created by Alfredo on 8/26/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    private func setupCell() {
    }
    
    func setup(with film: SearchMovieResponseResult) {
        titleLabel.text = film.title ?? "_"
        titleLabel.textAlignment = titleLabel.text!.constainsArabic ? .right : .left
    }
}
