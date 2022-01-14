//
//  SignUpVC.swift
//  TimelineApp
//
//  Created by TAGHREED on 07/05/1443 AH.
//

import UIKit

import Firebase

class SignUpVC: UIViewController {
    let db = Firestore.firestore()
    @IBOutlet weak var nameTV: UITextField!
    
    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var emailTV: UITextField!
    
    @IBOutlet weak var passTV: UITextField!
    
    @IBOutlet weak var alertLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        subview.layer.cornerRadius = 40
        
        subview.backgroundColor = #colorLiteral(red: 0.9284344316, green: 0.9335622191, blue: 0.9376024604, alpha: 1)
                      
    }
    
    @IBAction func SignUp(_ sender: Any) {
        if emailTV.text?.isEmpty == false && passTV.text?.isEmpty == false && nameTV.text?.isEmpty == false{
        Auth.auth().createUser(withEmail: emailTV.text!, password: passTV.text!) { authDataResult, err in
            if let err = err {
                
                print(err)
            }else{
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.nameTV.text
                changeRequest?.commitChanges { (error) in
                    if error == nil {
                        
                       print("displayName done")
                        print(Auth.auth().currentUser?.displayName)
                    }else{
                        
                        print(error)
                        
                    }
                }
                
                print("createing User is done ")
                self.performSegue(withIdentifier: "backToLog" , sender: nil )
                
            }
            
        }
        }else{
            
            alertLable.text = "fill all the textfield"
            print("fill all the textfield")
            
        }
    }
    
    @IBAction func login(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerid") as! ViewController
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
