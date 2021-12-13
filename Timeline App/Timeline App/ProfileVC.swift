//
//  ProfileVC.swift
//  Timeline App
//
//  Created by mac on 11/12/2021.
//

import UIKit
import Firebase

var mainName = "none"
class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var signOutBtn: UIButton!
    
    @IBOutlet weak var editImageBtn: UIButton!
    
    @IBOutlet weak var editNameBtn: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var image = UIImagePickerController()
    
    var imageRef = Storage.storage().reference().child("UsersProfile")
    @IBOutlet weak var nameLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signOutBtn.layer.cornerRadius = 15
        editImageBtn.layer.cornerRadius = 15
        editNameBtn.layer.cornerRadius = 15
        
        image.delegate = self
        
        downloadImage()
    }
    
    @IBAction func changeName(_ sender: Any) {
        alert()
    }
    
    func alert() {
       let alert = UIAlertController(title: "Change the name", message: "do you want change the name?", preferredStyle: .alert)
        
       alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
           self.nextAlert()
       }))
        
       alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
       present(alert, animated: true, completion: nil)
   }
    
    func nextAlert() {
        
        let alert = UIAlertController(title: "Whrite the new name", message: "", preferredStyle: .alert)
        
        alert.addTextField { textField in
            
            if textField.text != "" {
                
            } else {
                // the text is empty
            }
        }
        
        alert.addAction(UIAlertAction(title: "change", style: .default, handler: { action in
       
            if let name = alert.textFields?[0].text {
                
                self.nameLable.text = name
                mainName = name
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editImageBtn(_ sender: Any) {
        image.sourceType = .photoLibrary
        image.allowsEditing = true
        present(image, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
                if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    
                    if let imageData = selectedImage.jpegData(compressionQuality: 0.1) {
                        
                        imageRef.child("\(Auth.auth().currentUser!.uid)!").putData(imageData, metadata: nil){
                            (metaData , err) in
                            if let error = err {
                                print(error.localizedDescription)
                            }else {
                                print("تم رفع الصورة بنجاح")
                            }
                        }
                    }
             
                    profileImageView.contentMode = .scaleAspectFit
                    profileImageView.image = selectedImage
                 }

                 dismiss(animated: true, completion: nil)
            }
    
    func downloadImage(){
            
        let imageRefrence = imageRef.child("\(Auth.auth().currentUser!.uid)!")
            
            imageRefrence.getData(maxSize: 1 * 1024 * 1024) { data, error in
              
                if error != nil {

              } else {
                
                let image = UIImage(data: data!)
                self.profileImageView.contentMode = .scaleAspectFill
                self.profileImageView.image = image
                  
              }
            }
     
        }
    
    @IBAction func signOutClicked(_ sender: Any) {
        do {
                        try Auth.auth().signOut()
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }catch{
                        print(error.localizedDescription)
                    }
    }
    
    }

