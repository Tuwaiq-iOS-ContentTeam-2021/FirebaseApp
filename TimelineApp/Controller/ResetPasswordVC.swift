//
//  ResetPasswordVC.swift
//  TimelineApp
//
//  Created by WjdanMo on 13/12/2021.
//

import UIKit
import Firebase

class ResetPasswordVC: UIViewController {

    let password = UITextField()
    let save = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    @objc func savePasswordButtonClicked(){
        Auth.auth().currentUser?.updatePassword(to: password.text!, completion: { error in
            if error == nil{
                
                self.performSegue(withIdentifier: K.backToHomeVC, sender: nil)

            }
        })
    }
    
    func setup(){
        
        view.backgroundColor = .white
        
        password.textColor = .black
        password.frame = CGRect(x: view.frame.width/6, y: view.frame.height/4+90, width: 280, height: 30)
        password.backgroundColor = #colorLiteral(red: 0.8996704817, green: 0.8998214602, blue: 0.8996506333, alpha: 1)
        password.isSecureTextEntry = true
        password.layer.cornerRadius = 8
        view.addSubview(password)
        
        save.frame = CGRect(x: view.frame.width/4, y: view.frame.height/2 - 80, width: 200, height: 30)
        save.layer.cornerRadius = 8
        save.setTitle("save password", for: .normal)
        save.backgroundColor = .orange
        save.addTarget(self, action: #selector(savePasswordButtonClicked), for: .touchUpInside)
        view.addSubview(save)
    }
    
}
