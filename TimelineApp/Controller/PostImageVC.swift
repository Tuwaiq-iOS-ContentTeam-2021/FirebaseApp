//
//  PostImageVC.swift
//  TimelineApp
//
//  Created by WjdanMo on 12/12/2021.
//

import UIKit

class PostImageVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    let postImage = UIButton()
    let selectedImage = UIImageView()
    let imagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        showImagePicker()
        
    }
    
    func showImagePicker(){
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
//        imagePickerController.showsCameraControls = true
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            self.selectedImage.image = selectedImage
            
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    @objc func postButtonClicked(){
        if let image = selectedImage.image{
            PostService.create(for: image)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setup(){
        
        view.backgroundColor = .white
        
        postImage.frame = CGRect(x: view.frame.width - 100, y: 50, width: 80, height: 30)
        postImage.layer.cornerRadius = 8
        postImage.setTitle("post", for: .normal)
        postImage.backgroundColor = #colorLiteral(red: 0.02345971204, green: 0.03930909559, blue: 0.5252719522, alpha: 0.8470588235)
        postImage.addTarget(self, action: #selector(postButtonClicked), for: .touchUpInside)
        view.addSubview(postImage)
        
        selectedImage.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 200)
        selectedImage.layer.cornerRadius = 8
        view.addSubview(selectedImage)
        
        
    }
}
