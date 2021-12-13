//
//  ProfileViewController.swift
//  TimelineApp
//
//  Created by Ebtesam Alahmari on 10/12/2021.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    
    let db = Firestore.firestore()
    var userId = Auth.auth().currentUser?.uid
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIcon.layer.cornerRadius = userIcon.frame.width/2
        userIcon.tintColor = #colorLiteral(red: 0.4078431373, green: 0.2980392157, blue: 0.5960784314, alpha: 1)
        getData()
        
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let signOutBtn = UIAlertAction(title: "SignOut", style: .destructive) { alertAction in
            self.signOut()
        }
        alert.addAction(signOutBtn)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "signInVC") as! SignInViewController
            self.present(vc, animated: true, completion: nil)
        }catch {
            print("Error: ",error.localizedDescription)
        }
    }
    
    func getData() {
        if let userId = userId {
            db.collection("Users").document(userId).getDocument{ documentSnapshot, error in
                if let error = error {
                    print("Error: ",error.localizedDescription)
                }else {
                    self.nameLbl.text = documentSnapshot?.get("name") as? String ?? "nil"
                    self.userNameLbl.text = documentSnapshot?.get("userName") as? String ?? "nil"
                    let date = documentSnapshot?.get("joinedDate") as? Date ?? nil
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MMM d, yyyy"
                    var stringDate = formatter.string(from: date ?? Date() )
                    self.dateLbl.text = "🗓 Joined " + stringDate
                    let imgStr = documentSnapshot?.get("userIcon") as? String ?? "nil"
                    self.getImage(imgStr: imgStr)
                }
            }
        }
    }
    
    func getImage(imgStr: String) {
        let url = "gs://timelineapp-8d435.appspot.com/images/" + "\(imgStr)"
        let Ref = Storage.storage().reference(forURL: url)
        Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("Error: Image could not download!")
            } else {
                self.userIcon.image = UIImage(data: data!)
            }
        }
    }
    
    
}
