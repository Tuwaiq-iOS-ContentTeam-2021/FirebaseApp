//
//  SignUpViewController.swift
//  TimelineApp
//
//  Created by Ebtesam Alahmari on 10/12/2021.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    let userID = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    let imagePicker = UIImagePickerController()
    var imageName = "\(UUID().uuidString).png"
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        userImg.layer.cornerRadius = userImg.frame.width/2
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        if emailTxt.text != "" && passwordTxt.text != "" {
            Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) { user, error in
                if let error = error {
                    print("Error: ",error.localizedDescription)
                    let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }else {
                    self.addUser(documentName: (user?.user.uid)!)
                    self.performSegue(withIdentifier: "signUpToHome", sender: nil)
                }
            }
        }else {
            let alert = UIAlertController(title: "missing information", message: "Please enter email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func signIn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "signInVC") as! SignInViewController
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func editPhoto(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func addUser(documentName: String) {
        uploadImage()
        db.collection("Users").document(documentName).setData(
            [
                "name": nameTxt.text,
                "userName": userNameTxt.text,
                "userIcon": imageName,
                "joinedDate": Date()
            ]
        )
        {(error) in
            if let error = error {
                print("Error: ",error.localizedDescription)
            }else {
                print("new document has created..")
                let newUser = User( name: self.nameTxt.text!, icon: self.imageName, userName: self.userNameTxt.text!, joinedDate: Date())
                self.users.append(newUser)
            }
        }
    }
    
    
    func uploadImage(){
        let imagefolder = Storage.storage().reference().child("images")
        if let imageData = userImg.image?.jpegData(compressionQuality: 0.1) {
            imagefolder.child(imageName).putData(imageData, metadata: nil){
                (metaData , err) in
                if let error = err {
                    print(error.localizedDescription)
                }else {
                    print("تم رفع الصورة بنجاح")
                }
            }
        }
    }
    
    
}


//MARK: -UIImagePickerController
extension SignUpViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        userImg.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
}



