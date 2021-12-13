

import UIKit
import Firebase

class ResetPassword: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func reset(_ sender: Any) {
        Auth.auth().currentUser?.updatePassword(to: newPassword.text!) { error in
            if error == nil {
                print("تم تغيير كلمه السر بنجاح")
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    

}
