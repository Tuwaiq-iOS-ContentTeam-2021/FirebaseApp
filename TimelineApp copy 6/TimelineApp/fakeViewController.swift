//
//  fakeViewController.swift
//  TimelineApp
//
//  Created by TAGHREED on 07/05/1443 AH.
//

import UIKit
import Firebase
class fakeViewController: UIViewController {
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var passTV: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backView.layer.cornerRadius = 50
        alertView.layer.cornerRadius = 30
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reset(_ sender: Any) {
        Auth.auth().currentUser?.updatePassword(to: passTV.text!, completion: { err in
            if err == nil {
                print("pass updated sucssfully")
                self.dismiss(animated: false, completion: nil)
            }else{
                
                print(err)
            }
        }
        )
        
        
        
       
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: false, completion: nil)
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
