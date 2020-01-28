//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 17/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
 @IBOutlet weak var poster: UIImageView!
    
    func image(url: URL?) {
        if let url = url {
            poster.sd_setImage(with: url)
        } else {
            // fazer algo
        }
        
    }
    
}

protocol MovieCollectionViewCellDelegate: AnyObject {
    func cellTapped(movie: Movie)
}
