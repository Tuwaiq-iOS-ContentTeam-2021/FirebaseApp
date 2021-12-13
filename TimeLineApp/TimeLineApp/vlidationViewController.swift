//
//  vlidationViewController.swift
//  TimeLineApp
//
//  Created by Abrahim MOHAMMED on 12/12/2021.
//

import UIKit
import Firebase

class vlidationViewController: UIViewController {

    @IBOutlet weak var masageLable: UILabel!
    
    
    @IBOutlet weak var timerLable: UILabel!
    
    var idSams = ""
    
    var time = 59
    var miuntes = 2
    
    var timer: Timer? = nil
    
    
    @objc func action(){
        time -= 1
        if time == 0 {
            
           miuntes -= 1
            time = 59
            
        }
        timerLable.text = String(miuntes) + ":" + String(time)

    }
    
   
    @IBOutlet weak var NomberVlidation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendedyourverficationAcation(_ sender: Any) {
        
        masageLable.text = "verification code has been sent to your phone number *******8382"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
//
//        PhoneAuthProvider.provider().verifyPhoneNumber("+966598020127", uiDelegate: nil) { incode, erorr in
//            if erorr == nil{
//
//                self.idSams = incode!
//
//            }else{
//
//                print(erorr?.localizedDescription)
//
//
//
//            }
//
//
//        }
        
        
    }
    
    
    
    @IBAction func verifyAcation(_ sender: Any) {
        
//        let crdential = PhoneAuthProvider.provider().credential(withVerificationID: idSams, verificationCode:NomberVlidation.text! )
//        
//        Auth.auth().signIn(with: crdential) { AuthDataResult, error in
//            
//            if error == nil {
//                
//           
//                
//      
//  
//                
//                print("ccccc")
//                
//                
//            }else{
//                
//                print( error?.localizedDescription)
//                
//            }
//            
//        }
        self.performSegue(withIdentifier: "movepass", sender: nil)
    }
    

    
    

}
