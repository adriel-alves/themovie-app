//
//  ItemCollectionViewCell.swift
//  theMovie-app
//
//  Created by Adriel Alves on 17/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var uiMoviePoster: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var uiFavorite: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
