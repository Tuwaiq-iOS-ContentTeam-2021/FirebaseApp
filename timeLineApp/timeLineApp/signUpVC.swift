//
//  signUpVC.swift
//  timeLineApp
//
//  Created by Areej on 11/12/2021.
//

import UIKit
import Photos
import PhotosUI
import Firebase
class signUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,PHPickerViewControllerDelegate {
    
    
    var images = [UIImage]()
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                if let image = image as? UIImage{
                    DispatchQueue.main.async {
                        self.images.append(image)
                        self.photoProfile.image = image
                    }
                    
                }else {
                    print(error?.localizedDescription)
                }
            }
        }
    }
    @IBOutlet weak var nametxt: UITextField!
    @IBOutlet weak var emailtxt_su: UITextField!
    @IBOutlet weak var passwordtxt_su: UITextField!
    @IBOutlet weak var agetxt: UITextField!
    @IBOutlet weak var photoProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        photoProfile.layer.cornerRadius = photoProfile.frame.height/2
        photoProfile.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    @IBAction func backToSignin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupAction(_ sender: Any) {
        signup(email : emailtxt_su.text!, password : passwordtxt_su.text!)
        uplaodImage()
    }
    
    func signup(email : String, password : String){
        Auth.auth().createUser(withEmail: email, password: password) { AuthResult, err in
            if let error = err{
                
                print(error.localizedDescription)
            }else{
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.nametxt.text
                                changeRequest?.commitChanges { (error) in
                                    if error == nil {
                                        
                                       print("displayName done")
                                        print(Auth.auth().currentUser?.displayName)
                                    }else{
                                        
                                        print(error)
                                        
                                    }
                                }
                self.performSegue(withIdentifier:  "fromSUtoHome", sender: nil)
                    
                
                print("***** Successfuly registered *****")
                
            }
        }
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
      
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present (vc, animated: true)
    }
    let imageName = "\(UUID().uuidString).png"
    func uplaodImage(){
        let imagefolder = Storage.storage().reference().child("images")// child is a folder = collection
        if let imageData = photoProfile.image?.jpegData(compressionQuality: 0.1){
            
            imagefolder.child(imageName).putData(imageData, metadata: nil){
                (metadata, err) in
                if let error = err {
                    print(error.localizedDescription)
                    
                }else {
                    
                    print("image profile added successfuly")
                }
            }
        }
        
    }
    

}
