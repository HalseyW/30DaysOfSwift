//
//  InterestCollectionViewCell.swift
//  CarouselEffect
//
//  Created by HalseyW-15 on 2018/12/20.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelInterestTitle: UILabel!
    @IBOutlet weak var ivFeatured: UIImageView!
    
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        labelInterestTitle.text = interest.title
        ivFeatured.image = interest.featuredImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
