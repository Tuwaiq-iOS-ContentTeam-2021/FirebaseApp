//
//  SignIn.swift
//  Lola App
//
//  Created by Lola M on 12/12/21.
//

import UIKit
import FirebaseAuth


class SignIn: UIViewController {
    
    @IBOutlet weak var lblEmail : UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    //    @IBOutlet weak var vwActivityIndicator : UIView!
    //    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var signupBtnOutlet: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool) {
        if (firebaseManager.currentUser != nil) {
            self.performSegue(withIdentifier: "loginToHome", sender: nil)
        }
        
        if dataManager.isReachable {
            if let uid = FirebaseManager.shared.currentUser?.uid {
                FirebaseManager.shared.getUserInfo(forPerson: uid){ (key, valuesDict) in
                    if let valuesDict = valuesDict as? [AnyHashable: Any]{
                        let imageUrl = valuesDict["Image-URL"] as? String
                        let name = valuesDict["Name"] as? String
                        FirebaseManager.shared.currentUserDisplayName = name ?? "N/A"
                        FirebaseManager.shared.currentUserImageUrl = imageUrl ?? ""
                        //                                self.hideActivityIndicator()
                        self.performSegue(withIdentifier: "loginToHome", sender: nil)
                    }
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        signupBtnOutlet.titleLabel?.textAlignment = .left
        signupBtnOutlet.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        let str = self.validateFields()
        
        if str == "true"
        {
            DispatchQueue.main.async {
                //                self.showActivityIndicator()
            }
            if let email = lblEmail.text , let password = lblPassword.text {
                firebaseAuth.signIn(withEmail: email, password: password, completion: { user, error in
                    if let firebaseError = error{
                        //                        self.hideActivityIndicator()
                        self.showAlert(title: "Signed In Error", message: firebaseError.localizedDescription, hideAfter: 3.0)
                        return
                    }else{
                        FirebaseManager.shared.getUserInfo(forPerson: (FirebaseManager.shared.currentUser?.uid)!){ (key, valuesDict) in
                            if let valuesDict = valuesDict as? [AnyHashable: Any]{
                                let imageUrl = valuesDict["Image-URL"] as? String
                                let name = valuesDict["Name"] as? String
                                FirebaseManager.shared.currentUserDisplayName = name ?? "N/A"
                                FirebaseManager.shared.currentUserImageUrl = imageUrl ?? ""
                                //                                self.hideActivityIndicator()
                                self.performSegue(withIdentifier: "loginToHome", sender: nil)
                            }
                        }
                    }
                })
            }else{
                //                self.hideActivityIndicator()
            }
        }else{
            self.showAlert(title: "Warning", message: "Fill out all the Fields before signing up", hideAfter: 3.0)
        }
        
    }
    
    //    func showActivityIndicator() {
    //        self.activityIndicator.startAnimating()
    //        self.vwActivityIndicator.isHidden = false
    //    }
    
    //    func hideActivityIndicator() {
    //        self.activityIndicator.stopAnimating()
    //        self.vwActivityIndicator.isHidden = true
    //    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func validateFields()->String
    {
        let emailString = lblEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordString = lblPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if emailString == "" || passwordString == "" {
            return "false"
        }
        return "true"
    }
    
    
    @IBAction func btnSignUpClicked(){
        //        self.navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: "loginToSignup", sender: self)
    }
    
    @IBAction func btnForgotPasswordClicked() {
        
        if self.lblEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            Auth.auth().sendPasswordReset(withEmail: self.lblEmail.text!) { error in
                    if error != nil {
                        self.showAlert(title: "Bad Email", message: error?.localizedDescription, hideAfter: 5.0)
                    } else {
                        //..
                    }
                }
            } else {
                self.showAlert(title: "Bad Email", message: "Please write a valid email address and then click forget password", hideAfter: 5.0)
            }
    }
    
    
}
