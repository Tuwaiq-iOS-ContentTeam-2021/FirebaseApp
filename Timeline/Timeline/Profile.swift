//
//  Profile.swift
//  Timeline
//
//  Created by Sahab Alharbi on 06/05/1443 AH.
//

import UIKit
import Firebase

class Profile: UIViewController {
    var name = ""
    var userName = ""
    
    @IBOutlet weak var nameL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameL.text = userName
        // Do any additional setup after loading the view.
    }
    @IBAction func signOutButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Sign Out", message: "Would you like to Sign Out ?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Sign Out", style: UIAlertAction.Style.destructive, handler: {(_: UIAlertAction!) in
            do {
                try Auth.auth().signOut()
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar
                self.present(vc, animated: true, completion: nil)
            } catch{
                print("error",error.localizedDescription)
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
}
