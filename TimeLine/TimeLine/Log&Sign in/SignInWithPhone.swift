
import UIKit
import Firebase

class SignInWithPhone: UIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    var idSMS : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signIn(_ sender: Any) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber.text!, uiDelegate: nil) { idcode, error in
            if error == nil {
                self.idSMS = idcode
                self.performSegue(withIdentifier: "moveverfaction", sender: self)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveverfaction" {
            let vc = segue.destination as! ConfirmPhone
            vc.codeId = idSMS
            
        }
      
    }
}
