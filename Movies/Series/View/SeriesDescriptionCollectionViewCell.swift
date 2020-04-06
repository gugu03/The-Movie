//
//  SeriesDescriptionCollectionViewCell.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 31/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit
import SDWebImage

class SeriesDescriptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterPath: UIImageView!
    
    @IBOutlet weak var nameSeasons: UILabel!

    func setupSeasons(serieDescription: DescriptionSeason?) {
        posterPath.sd_setImage(with: serieDescription?.posterURL)
        nameSeasons.text = serieDescription?.name
    }
}
