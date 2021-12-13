

import UIKit
import Firebase

class ConfirmPhone: UIViewController {
    
    var codeId : String?
    
    @IBOutlet weak var code: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signIn(_ sender: Any) {
        let codeSms = PhoneAuthProvider.provider().credential(withVerificationID: codeId!, verificationCode: code.text!)
        Auth.auth().signIn(with: codeSms) { users, error in
            if error == nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! UITabBarController
                self.present(vc, animated: true, completion: nil)
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
}
