//
//  EntryViewController.swift
//  HackPhotoManager
//
//  Created by WU CHIH WEI on 2017/9/29.
//  Copyright © 2017年 lukewu. All rights reserved.
//

import UIKit

let kSegueOpenCamera = "OpenCamera"

class EntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }
    
    func setupLayout() {
        self.addGestureRecognizer()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func addGestureRecognizer() {
        let slide = UISwipeGestureRecognizer(target: self, action: #selector(openCameraPicker))
        slide.direction = UISwipeGestureRecognizerDirection.left
        slide.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(slide)
    }
    
    func openCameraPicker () {
        self.performSegue(withIdentifier: kSegueOpenCamera, sender: nil)
    }
    
}
