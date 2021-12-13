//
//  CheckAuthVC.swift
//  Timeline App
//
//  Created by mac on 11/12/2021.
//

import UIKit
import Firebase
class CheckAuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {

        if Auth.auth().currentUser?.uid != nil {
            performSegue(withIdentifier: "moveTimeline", sender: self)
        }else {
            performSegue(withIdentifier: "moveLogin", sender: self)
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
