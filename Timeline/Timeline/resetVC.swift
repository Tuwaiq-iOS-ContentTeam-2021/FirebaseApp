//
//  resetVC.swift
//  Timeline
//
//  Created by Najla Talal on 12/11/21.
//

import UIKit
import Firebase
class resetVC: UIViewController {

    @IBOutlet weak var resetTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func change(_ sender: Any) {
        Auth.auth().currentUser?.updatePassword(to: resetTF.text!) { error in
         
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
