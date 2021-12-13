//
//  SignUp.swift
//  Lola App
//
//  Created by Lola M on 12/12/21.
//

import UIKit
import Firebase
import FirebaseAuth



class SignUp: UIViewController {
    
//    @IBOutlet weak var vwActivityIndicator : UIView!
//    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    
    var pImageSelected = false
    @IBOutlet weak var imgVwProfile : UIImageView!
    @IBOutlet weak var btnAddProfileImage : UIButton!
    @IBOutlet weak var lblName : UITextField!
    @IBOutlet weak var lblEmail : UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblRepPassword: UITextField!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        loginBtnOutlet.titleLabel?.textAlignment = .left
        loginBtnOutlet.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        imgVwProfile.layer.cornerRadius = imgVwProfile.frame.size.width / 2
        imgVwProfile.clipsToBounds = true
    }
    
    @IBAction func btnProfileImageClicked() {
        
    }
    
    
    @IBAction func btnSignUpClicked() {

        let str = self.validateFields()
        
        if str == "true"
        {
            if ((lblPassword.text!.elementsEqual(lblRepPassword.text!)) == true)
            {
                if let email = lblEmail.text?.lowercased(), let name = lblName.text , let password = lblPassword.text{
                    DispatchQueue.main.async {
//                        self.showActivityIndicator()
                    }
                    firebaseAuth.createUser(withEmail: email, password: password,completion:{ user, error in
                        if let firebaseError = error{
//                            self.hideActivityIndicator()
                            self.dismissKeyboard()
                            self.showAlert(title: "Signed Up Error", message: firebaseError.localizedDescription, hideAfter: 4.0)
                            return
                        }else{
                            if self.pImageSelected == true {
                                if let image = self.imgVwProfile.image{
                                    if let imageData = image.jpegData(compressionQuality: 0.1){
                                     let newImage = UIImage(data: imageData)
                                
                                        FirebaseManager.shared.uploadImageToFirebaseStorage(imageName:"\(FirebaseManager.shared.currentUser?.uid ?? "not available")", imageToUpload: newImage! ) { (url, error) in
                                
                                if error == nil{
                                    DispatchQueue.global(qos: .background).async {
                                        
                                        
                                        let post : [AnyHashable : Any] =
                                        ["Name": name,
                                         "Email": email,
                                         "UID": user?.user.uid ?? "",
                                         "Image-URL": url
                                        ]
                                        
                                        if let userid = FirebaseManager.shared.currentUser?.uid{
                                            FirebaseManager.shared.currentUserDisplayName = name
                                            FirebaseManager.shared.changeUserStatusForSignUp(post: post, for: userid)
                                        }
                                        self.signIn(withemail: email, andpassword: password)
                                    }
                                }else{
//                                    self.hideActivityIndicator()
                                    self.showAlert(title: "Oos", message: "Something went wrong while uploading the image\nPlease try again later", hideAfter: 4.0)
                                }
                            }
                                    }
                             
                                }
                            }else{
                                
                                DispatchQueue.global(qos: .background).async {
                                    
                                    let post : [AnyHashable : Any] =
                                        ["Name": name,
                                         "Email": email,
                                         "UID": user?.user.uid ?? "",
                                         "Image-URL": ""
                                    ]
                                    
                                    if let userid = FirebaseManager.shared.currentUser?.uid{
                                        FirebaseManager.shared.currentUserDisplayName = name
                                        FirebaseManager.shared.changeUserStatusForSignUp(post: post, for: userid)
                                    }
                                    self.signIn(withemail: email, andpassword: password)
                                }
                            }
                        }
                    })
                }
            }
            else
            {
                self.showAlert(title: "Warning", message: "password not matched", hideAfter: 4.0)
            }
            
        }
        else{
            self.showAlert(title: "Warning", message: "Fill out all the Fields before signing up", hideAfter: 9.0)
        }
    }
    
    func validateFields()->String
    {
        let nameString = lblName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailString = lblEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordString = lblPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let repasswordString = lblRepPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if nameString == "" || emailString == "" || passwordString == "" || repasswordString == "" {
            return "false"
        }
        
        return "true"
    }
    
//    func showActivityIndicator() {
//        self.activityIndicator.startAnimating()
//        self.vwActivityIndicator.isHidden = false
//    }
//
//    func hideActivityIndicator() {
//        self.activityIndicator.stopAnimating()
//        self.vwActivityIndicator.isHidden = true
//    }
    
    func signIn(withemail : String, andpassword : String){
        firebaseAuth.signIn(withEmail: withemail, password: andpassword, completion: { user, error in
            if let firebaseError = error{
//                self.hideActivityIndicator()
                self.showAlert(title: "Signed In Error", message: firebaseError.localizedDescription, hideAfter: 4.0)
                return
            }else{
                FirebaseManager.shared.getUserInfo(forPerson: (FirebaseManager.shared.currentUser?.uid)!){ (key, valuesDict) in
                    if let valuesDict = valuesDict as? [AnyHashable: Any]{
                        let imageUrl = valuesDict["Image-URL"] as? String
                        FirebaseManager.shared.currentUserImageUrl = imageUrl ?? ""
//                        self.hideActivityIndicator()
                        self.performSegue(withIdentifier: "signupToHome", sender: self)
                    }
                }
            }
        })
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        if self.view.frame.origin.y != 0 {
            UIView.animate(withDuration: 0.5,
            delay: 0.0,
            options: [],
            animations: {
                self.view.frame.origin.y = 0.0
            },
            completion: nil)
        }
    }
    
    @IBAction func btnSignInClicked(){
        self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
    
}
    



extension SignUp : MediaPickerControllerDelegate {
      func picker(_ controller: MediaPickerViewController, didFinishPickingMedia type: MediaType, url: URL?, error: Error?) {
          controller.dismiss(animated: true) {
              if controller.supportedMediaTypes == .image {
                  if let url = url, let data = try? Data(contentsOf: url){
                      
                      self.imgVwProfile.image = UIImage(data: data)
                    self.pImageSelected = true
                  }
              }
          }
      }
      
      func pickerDidCancel(_ controller: MediaPickerViewController) {
          
      }
      
    
  @IBAction func selectMediaForUploading(_ sender : UIButton){
      let picker = MediaPickerViewController()
      picker.delegate = self
      picker.supportedMediaTypes = .image
      picker.modalPresentationStyle = .overCurrentContext
      self.present(picker, animated: true)
  }
      
  }
  




extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}


