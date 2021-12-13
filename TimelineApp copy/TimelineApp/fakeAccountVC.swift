//
//  fakeAccountVC.swift
//  TimelineApp
//
//  Created by TAGHREED on 09/05/1443 AH.
//

import UIKit
import Firebase
class fakeAccountVC: UIViewController {
    @IBOutlet weak var oView: UIView!
    @IBOutlet weak var accImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var wView: UIView!
    @IBOutlet weak var gView: UIView!
    @IBOutlet weak var accButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        accButton.isEnabled = false
        name.text = cu?.displayName
        oView.layer.cornerRadius = 50
        gView.layer.cornerRadius = 30
        wView.layer.cornerRadius = 30
        accImg.makeRounded()
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func logOut(_ sender: Any) {
        do{
       try  Auth.auth().signOut()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerid") as! ViewController
                 vc.modalPresentationStyle = .fullScreen
                 present(vc, animated: false, completion: nil)
        }catch{
            
            print("error")
        }
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
