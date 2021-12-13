//
//  ViewController.swift
//  TimelineApp
//
//  Created by TAGHREED on 07/05/1443 AH.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    @IBOutlet weak var emailTV: UITextField!
   // @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var sView: UIView!
    @IBOutlet weak var passTV: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        sView.layer.cornerRadius = 50
        view.backgroundColor = UIColor(named: "o")
        // Do any additional setup after loading the view.
        
        
        
    }
    
    @IBAction func reset(_ sender: Any) {
        
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "fakeViewControllerid") as! fakeViewController
                 vc.modalPresentationStyle = .fullScreen
                 present(vc, animated: false, completion: nil)
            
    }
    
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTV.text!, password: passTV.text!) { authDataResult, err in
            if  err == nil {
                print("loged in sucssfully")
                self.performSegue(withIdentifier: "moveToHome", sender: self)//nil or self?
                // idont want it to move if it dosent loged in sucssfully!
                
                
                
                
            }else{
                print(err)
            }
            
            
            
        }
        
        
        
        
    }
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "logToSign", sender: nil)
    }
    
    
    
    
    //    func checkForUser(){
    //
    //    if Auth.auth().currentUser?.uid != nil {
    //  performSegue(withIdentifier: "moveToHome", sender: self)
    
    // }//check for log
    //    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //end
}

