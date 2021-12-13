
import UIKit
import Firebase

class SignUp: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = name
    }
    @IBAction func signUp(_ sender: Any) {
        if self.password.text != self.confirmPassword.text {
            let dialogMessage = UIAlertController(title: "Ops!", message: "confirm password not match", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok to login or signup")
            })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        if password.text == confirmPassword.text {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
                if error == nil {
                    print("تم انشاد حساب جديد بنجاح")
                    let dialogMessage = UIAlertController(title: "Registering", message: "you are successfully register", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default){_ in
                        do {
                          try Auth.auth().signOut()
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "back") as! LogIn
                            self.present(vc, animated: true, completion: nil)                        } catch {
                          print(error.localizedDescription)
                        }
                    }
                    dialogMessage.addAction(ok)
                    self.present(dialogMessage, animated: true, completion: nil)
                }else{
                    print(error?.localizedDescription)
//                    if Auth.auth().currentUser != nil {
                        let dialogMessage = UIAlertController(title: "Ops!", message: error?.localizedDescription, preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                            print("Ok to login or signup")
                        })
                        dialogMessage.addAction(ok)
                        self.present(dialogMessage, animated: true, completion: nil)
//                    }
                    
                }
            }
        }
        
    }
    
}
