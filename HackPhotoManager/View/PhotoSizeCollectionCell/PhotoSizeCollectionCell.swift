//
//  PhotoSizeCollectionCell.swift
//  HackPhotoManager
//
//  Created by WU CHIH WEI on 2017/9/29.
//  Copyright © 2017年 lukewu. All rights reserved.
//

import UIKit

class PhotoSizeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var sizeLabel:UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.setupSizeLabel()
    }
    
    func setupSizeLabel() {
        self.sizeLabel.layer.cornerRadius = 5.0
        self.sizeLabel.layer.borderWidth = 2.0
        self.sizeLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.sizeLabel.backgroundColor = UIColor.white.withAlphaComponent(0.8)
    }
}
