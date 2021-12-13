//
//  ViewController.swift
//  Timeline
//
//  Created by Sahab Alharbi on 06/05/1443 AH.
//

import UIKit
import Firebase
import GoogleSignIn
class SignUp: UIViewController {
    let firestore = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signupG: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        if emailTF.text == "" || nameTF.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your name and email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar
                    self.present(vc, animated: true, completion: nil)
                    
                } else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    @IBAction func SignUpGoogleButton(_ sender: Any) {
        
        let clientID = FirebaseApp.app()?.options.clientID
        let configId = GIDConfiguration(clientID: clientID!)
        GIDSignIn.sharedInstance.signIn(with: configId , presenting: self) { GoogleUser, error in
            if error == nil {
                let authntic = GoogleUser?.authentication
                let idToken = authntic?.idToken
                let auth = GoogleAuthProvider.credential(withIDToken: idToken!, accessToken: authntic!.accessToken )
                Auth.auth().signIn(with: auth) { user, error in
                    if error == nil {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile" {
            let vs =  Profile()
            //                    vs.name = Auth.auth().createUser?.displayName ?? ""
            vs.userName = nameTF.text!
        }
    }
    
    
}
//
