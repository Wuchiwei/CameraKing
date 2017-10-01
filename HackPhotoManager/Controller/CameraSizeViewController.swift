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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.collectionView.backgroundColor = UIColor.clear
    }
}

extension CameraSizeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kIdentifyCell, for: indexPath)
        guard let sizeCell = cell as? PhotoSizeCollectionCell else { return cell }
        return cell
    }
}

extension CameraSizeViewController: UICollectionViewDelegateFlowLayout {
    
}
