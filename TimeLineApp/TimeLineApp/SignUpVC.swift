//
//  SignUpVC.swift
//  TimeLineApp
//
//  Created by Badreah Saad on 11/12/2021.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    var myImage: UIImage? = nil
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
    }
    
    
    @IBAction func userSignup(_ sender: Any) {
        
        guard let imageSelected = self.myImage else {
            print("image is nil!")
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            return
        }
        
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
            if error == nil {
                print("User SignUP!")
                self.displayUserName()
                self.performSegue(withIdentifier: "signup", sender: self)
            } else {
                print("no user created", error?.localizedDescription)
            }
        }
        
        let storRef = Storage.storage().reference(forURL: "gs://timelineapp-cbe0e.appspot.com")
        
        let profileRef = storRef.child("profile").child(Auth.auth().currentUser?.uid ?? "no user!!")
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        profileRef.putData(imageData, metadata: metaData) { storeData, error in
            if error != nil {
                print("err!!",error?.localizedDescription)
                return
            }
        }
        
        profileRef.downloadURL { url, err in
            if let imageURL = url?.absoluteString {
                print("yes!!", imageURL)
                self.db.collection("Posts").addDocument(data: [
                    "userImage": imageURL
                ])
            }
        }
        
        
        
    }
    
    
    
    func displayUserName() {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.userNameField.text
        changeRequest?.commitChanges { (error) in
            if error == nil {
                
                print("displayName done")
                print(Auth.auth().currentUser?.displayName)
            }else{
                
                print(error)
                
            }
        }
    }
    
    func setImage() {
        userImage.layer.cornerRadius = 20
        userImage.clipsToBounds = true
        userImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(pPicker))
        userImage.addGestureRecognizer(tap)
    }
    
    
    @objc func pPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func userSelectedImage(_ sender: Any) {
        pPicker()
        
    }
    
    
}


extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            myImage = selectedImage
            userImage.image = selectedImage
        }
        if let oriImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            myImage = oriImage
            userImage.image = oriImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}
