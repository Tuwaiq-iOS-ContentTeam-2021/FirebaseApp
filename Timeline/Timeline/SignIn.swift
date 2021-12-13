//
//  SignIn.swift
//  Timeline
//
//  Created by Sahab Alharbi on 06/05/1443 AH.
//

import UIKit
import Firebase
import GoogleSignIn
class SignIn: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func logInButton(_ sender: Any) {
        if self.emailTF.text == "" || self.passwordTF.text == "" {
            
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailTF.text!, password: self.passwordTF.text!) { (user, error) in
                
                if error == nil {
                    
                    print("You have successfully logged in")
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar
                    self.present(vc, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        
        
    }
    @IBAction func signINGoogle(_ sender: Any) {
        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
