

import UIKit
import Firebase

class SignOutPage: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signOut(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }catch {
            print(error.localizedDescription)
        }
    }
}
