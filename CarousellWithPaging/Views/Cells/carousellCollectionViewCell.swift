//
//  carousellCollectionViewCell.swift
//  CarousellWithPaging
//
//  Created by עמית נדיר on 23/10/2019.
//  Copyright © 2019 AmitLTD. All rights reserved.
//

import UIKit

class carousellCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCard()
    }
    
    func setUpCard(){
        cellImageView.layer.cornerRadius = 8.0
        cellImageView.clipsToBounds = true
    }

}
