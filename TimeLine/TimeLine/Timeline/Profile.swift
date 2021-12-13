

import UIKit
import Firebase

class Profile: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phonenumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.makeRounded()
    }
    func getProfile(){
        //        let user = Auth.auth().currentUser
        //        if let user = user {
        //          // The user's ID, unique to the Firebase project.
        //          // Do NOT use this value to authenticate with your backend server,
        //          // if you have one. Use getTokenWithCompletion:completion: instead.
        //          let uid = user.uid
        //          let email = user.email
        //          let photoURL = user.photoURL
        //          var multiFactorString = "MultiFactor: "
        //          for info in user.multiFactor.enrolledFactors {
        //            multiFactorString += info.displayName ?? "[DispayName]"
        //            multiFactorString += " "
        //          }
        //          // ...
        //        }
    }
    
    @IBAction func changePhoto(_ sender: Any) {
    }
    
    @IBAction func logOut(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to LogOut", preferredStyle: .alert)
            let action = UIAlertAction(title: "Log out", style: .default) {_ in
              do {
                try Auth.auth().signOut()
                  self.performSegue(withIdentifier: "out", sender: self)
              } catch {
                print(error.localizedDescription)
              }
            }
            alert.addAction(action)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        
    }
}
