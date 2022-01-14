//
//  AccountVC.swift
//  TimelineApp
//
//  Created by TAGHREED on 07/05/1443 AH.
//

import UIKit
import Firebase
class AccountVC: UIViewController {
   let cu = Auth.auth().currentUser
    
    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var accountOutlet: UIButton!
    @IBOutlet weak var accImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var joinedDate: UILabel!//not yet
    @IBOutlet weak var bio: UILabel!//not yet
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        accountOutlet.isEnabled = false
        accImg.makeRounded()
        name.text = cu?.displayName
        userName.text = "@\(cu?.uid ?? "noUser")"
        backView.layer.cornerRadius = 50
        backView2.layer.cornerRadius = 30
        
    }
    
    
    
    
    @IBAction func signOut(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "fakeAccountVCid") as! fakeAccountVC
             vc.modalPresentationStyle = .fullScreen
             present(vc, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContentVCid") as! ContentVC
             vc.modalPresentationStyle = .fullScreen
             present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func homeButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCid") as! HomeVC
             vc.modalPresentationStyle = .fullScreen
             present(vc, animated: true, completion: nil)
        
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
extension UIImageView {

    func makeRounded() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
