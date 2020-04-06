//
//  FavoriteSeriesCollectionViewCell.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 19/02/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit

class FavoriteSeriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var poster: UIImageView!
    
    func setupImage( posterPath: String) {
     guard let url = URL(string: posterPath ) else { return }
     poster.sd_setImage(with: url)
 }

}
