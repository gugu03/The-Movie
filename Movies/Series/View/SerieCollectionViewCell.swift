//
//  SerieCollectionViewCell.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 18/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit

class SerieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var poster: UIImageView!
    
   func imageSerie(url: URL?) {
        if let url = url {
            poster.sd_setImage(with: url)
        } else {
           
        }
    }
    
}
protocol SerieCollectionViewCellDelegate: AnyObject {
    func cellTapped(serie: Serie)
}
