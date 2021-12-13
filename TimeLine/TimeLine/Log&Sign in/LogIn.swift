

import UIKit
import Firebase

class LogIn: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func logIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) {  authResult, error in
            if error == nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! UITabBarController
                self.present(vc, animated: true, completion: nil)
            }else{
                print(error?.localizedDescription)
                if Auth.auth().currentUser != nil {
                    let dialogMessage = UIAlertController(title: "Ops!", message: error?.localizedDescription, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok to login or signup")
                    })
                    dialogMessage.addAction(ok)
                    self.present(dialogMessage, animated: true, completion: nil)
                }
            }
            
        }
    }
}

