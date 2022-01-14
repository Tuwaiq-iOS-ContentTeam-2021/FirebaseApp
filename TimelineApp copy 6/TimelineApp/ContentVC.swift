//
//  ContentVC.swift
//  TimelineApp
//
//  Created by TAGHREED on 07/05/1443 AH.
//

import UIKit
import Firebase

class ContentVC: UIViewController {
    @IBOutlet weak var addOutlet: UIButton!
    
    @IBOutlet weak var postOutlut: UIButton!
    @IBOutlet weak var textArea: UITextView!
    //var SingVc = SignUpVC()
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        addOutlet.isEnabled = false
        postOutlut.layer.cornerRadius = 20
        textArea.layer.cornerRadius = 30
        // Do any additional setup after loading the view.
    }
    
  
    func addCollection(){
        db.collection("TimeLine").addDocument(data: ["name" : Auth.auth().currentUser?.displayName , "UserId":Auth.auth().currentUser?.uid , "UserImg" : "", "tweet": textArea.text])
        { (error) in
            if error == nil {
                
                print("new doc has been creauted..")
                
            }else{
                
                print(error)
           }
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCid") as! HomeVC
             vc.modalPresentationStyle = .fullScreen
             present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func send(_ sender: Any) {
        
        addCollection()
        
    }
    
    
    @IBAction func homeButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCid") as! HomeVC
             vc.modalPresentationStyle = .fullScreen
             present(vc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func accountButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountVCid") as! AccountVC
             vc.modalPresentationStyle = .fullScreen
             present(vc, animated: true, completion: nil)
             
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
//extension UIButton {
//
//    func moveToHome() {
//
//    }
//
//
//
//}
