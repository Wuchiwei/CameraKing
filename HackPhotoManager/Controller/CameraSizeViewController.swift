//
//  CameraSizeViewController.swift
//  HackPhotoManager
//
//  Created by WU CHIH WEI on 2017/9/29.
//  Copyright © 2017年 lukewu. All rights reserved.
//

import UIKit

let kIdentifyCell = "SizeCell"

class CameraSizeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var selectedSize: Int?
    
    var touchHandler: (()->())?
    
    let sizes = PhotoSizeManager().photoSizes
    
    var sizeScale: Double {
        guard let index = self.selectedSize else {
            guard let scale = self.sizes.last?.rawValue else { return 1.0 }
            return scale
        }
        return self.sizes[index].rawValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.collectionView.backgroundColor = UIColor.clear
    }
}

extension CameraSizeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sizes.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kIdentifyCell, for: indexPath)
        guard let sizeCell = cell as? PhotoSizeCollectionCell else { return cell }
        sizeCell.sizeLabel.text = self.sizes[indexPath.row].representString()
        return cell
    }
}

extension CameraSizeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.selectedSize = indexPath.row
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.touchHandler?()
        }
    }
}
