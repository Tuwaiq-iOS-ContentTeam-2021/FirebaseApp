//
//  Post.swift
//  timeLine
//
//  Created by nouf on 10/12/2021.
//

import UIKit
import Firebase

class Post: UIViewController  {
    var imagePickerController : UIImagePickerController!
    @IBOutlet weak var textviewcontent: UITextView!
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    var nameUser = ""
    let imageName = "\(UUID().uuidString).png"
    
    @IBOutlet var ImageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addImageButton.layer.cornerRadius =  addImageButton.bounds.size.height/2
        addImageButton.layer.masksToBounds = true
        let name = db.collection("Users").whereField( "email", isEqualTo: user?.email!).addSnapshotListener{(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    self.nameUser = data["Name"] as! String
                    
                }
            }
        }
    }
    
    @IBAction func addPost(_ sender: Any) {
        
        creatPost()
        uploadImage(imageName: imageName)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func addImage(_ sender: Any) {
        
        pickPhoto()
        
        
    }
    
    
    // MARK: - Upload image
    func uploadImage(imageName : String) {
        
        let imageFolder = Storage.storage().reference().child("images")
        if let imageData = ImageView?.image?.jpegData(compressionQuality: 0.1) {
            imageFolder.child(imageName).putData(imageData, metadata: nil)
            { (querySnapshot, err) in
                if let err = err {
                    print("Error : \(err.localizedDescription)")
                } else {
                    print("Is uploud")
                    
                }
            }
        }
        
        
        
        
        
        
    }
    
    
    
    // MARK: - Post function
    
    func creatPost() {
        
        db.collection("TimeLine").document().setData([
            
            "userName" : nameUser,
            "userID" : user!.uid ,
            "post" : textviewcontent.text! ,
            "date" :  Date().timeIntervalSince1970
            
        ]){ (error) in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
                
            } else {
                
                print("Document added ")
            }
        }
    }
}



// MARK: - add image
extension Post : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    // MARK:- Image Picker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        ImageView.image = pickedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    func pickPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    func showPhotoMenu() {
        let alert = UIAlertController(title: nil, message: nil,
                                      preferredStyle: .actionSheet)
        
        let actCancel = UIAlertAction(title: "Cancel", style: .cancel,
                                      handler: nil)
        alert.addAction(actCancel)
        
        let actPhoto = UIAlertAction(title: "Take Photo",
                                     style: .default, handler: nil)
        alert.addAction(actPhoto)
        
        let actLibrary = UIAlertAction(title: "Choose From Library",
                                       style: .default, handler: nil)
        alert.addAction(actLibrary)
        
        present(alert, animated: true, completion: nil)
    }
}
