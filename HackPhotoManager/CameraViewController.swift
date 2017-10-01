//
//  CameraViewController.swift
//  HackPhotoManager
//
//  Created by WU CHIH WEI on 2017/9/25.
//  Copyright © 2017年 lukewu. All rights reserved.
//

import UIKit

let kSizePicker = "OpenSizePicker"

class CameraViewController: UIViewController {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var toolView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var takePicButton: UIButton!
    @IBOutlet weak var viewSizeButton: UIButton!
    
    weak var sizeVC: CameraSizeViewController?
    
    var imagePickerVC: UIImagePickerController?
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewSizeButton.layer.cornerRadius = self.viewSizeButton.frame.size.width / 2.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: Layout & Animations
    func setupLayout() {
        self.setupImagePickerViewController()
        self.setupTakePicButton()
        self.setupToolView()
    }
    
    func setupToolView() {
        self.toolView.alpha = 0.0
        self.toolView.isUserInteractionEnabled = false
    }
    
    func setupImagePickerViewController() {
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is not avaliable")
            return
        }
        
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .camera
        imagePickerVC.delegate = self
        imagePickerVC.showsCameraControls = false
        imagePickerVC.navigationController?.navigationBar.isHidden = true
        
        self.addChildViewController(imagePickerVC)
        
        self.cameraView.addSubview(imagePickerVC.view)
        imagePickerVC.view.translatesAutoresizingMaskIntoConstraints = false
        imagePickerVC.view.centerXAnchor.constraint(equalTo: self.cameraView.centerXAnchor).isActive = true
        imagePickerVC.view.centerYAnchor.constraint(equalTo: self.cameraView.centerYAnchor).isActive = true
        imagePickerVC.view.heightAnchor.constraint(equalTo: self.cameraView.heightAnchor).isActive = true
        imagePickerVC.view.widthAnchor.constraint(equalTo: self.cameraView.widthAnchor).isActive = true
        
        imagePickerVC.didMove(toParentViewController: self)
        self.imagePickerVC = imagePickerVC
    }

    func setupTakePicButton() {
        self.takePicButton.layer.cornerRadius = 32.0;
        self.takePicButton.layer.borderColor = UIColor.lightGray.cgColor
        self.takePicButton.layer.borderWidth = 4.0
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: Actions
    @IBAction func takePicture() {
        self.imagePickerVC?.takePicture()
    }
    
    @IBAction func turnCamera() {
        guard let imagePickerVC = self.imagePickerVC else { return }
        
        switch imagePickerVC.cameraDevice {
        case .front:
            imagePickerVC.cameraDevice = .rear
        case .rear:
            imagePickerVC.cameraDevice = .front
        }
    }
    
    @IBAction func openSizePicker() {
        UIView.animate(withDuration: 0.3) {
            self.toolView.alpha = 1.0
            self.toolView.isUserInteractionEnabled = true
        }
    }
    
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case kSizePicker:
            guard let vc = segue.destination as? CameraSizeViewController else { return }
            self.sizeVC = vc
            vc.touchHandler = { [weak self] in
                self?.setupToolView()
            }
            return
        default:
            return
        }
        
    }
    
    //MARK: Support Method
    func scale(image:UIImage, toScale scale:CGFloat) -> UIImage? {
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(origin: CGPoint.init(x: 0.0, y: 0.0), size: size))
        guard let scaleImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        return scaleImage
    }
}

    //MARK: UIImagePickerControllerDelegate

extension CameraViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let originImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        guard let originData = UIImageJPEGRepresentation(originImage, 1) else { return }
        print("origin data file size \(originData.count)")
        print("origin pic size: \(originImage.size)")
        
        let scale = self.sizeVC?.sizeScale ?? 1.0
        guard let scaleImage = self.scale(image: originImage, toScale: CGFloat(scale)) else { return }
        guard let scaleData = UIImageJPEGRepresentation(scaleImage, 1) else { return }
        print("scale data file size: \(scaleData.count)")
        print("scale pic size: \(scaleImage.size)")
        
        UIImageWriteToSavedPhotosAlbum(scaleImage, nil, nil, nil)
//        self.closeController()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.closeController()
    }
    
    func closeController() {
        self.navigationController?.popViewController(animated: true)
    }
 }

