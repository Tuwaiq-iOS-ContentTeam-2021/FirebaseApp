//
//  SignUpVC.swift
//  TimelineApp
//
//  Created by WjdanMo on 10/12/2021.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    let name = UITextField()
    let userName = UITextField()
    let email = UITextField()
    let password = UITextField()
    let signUp = UIButton()
    let logInLabel = UILabel()
    let logIn = UIButton()
    
    let signUpObj = SignUpLogInModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func signUpButtonClicked(){
        
        if let name = name.text, let username = userName.text,
           let email = email.text, let password = password.text {
            
            if signUpObj.signUpAction(name, username, email, password){
                HomeVC().modalPresentationStyle = .fullScreen
                present(HomeVC(), animated: true, completion: nil)
            }
            
            else {
                // pop up failed to sign up
            }
        }
    }
    
    @objc func logInButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setup(){
        
        name.textColor = .black
        name.placeholder = " Name"
        name.frame = CGRect(x: view.frame.width/6, y: view.frame.height/4+40, width: 280, height: 30)
        name.backgroundColor = #colorLiteral(red: 0.8996704817, green: 0.8998214602, blue: 0.8996506333, alpha: 1)
        name.layer.cornerRadius = 8
        view.addSubview(name)
        
        userName.textColor = .black
        userName.placeholder = " Username"
        userName.frame = CGRect(x: view.frame.width/6, y: view.frame.height/3, width: 280, height: 30)
        userName.backgroundColor = #colorLiteral(red: 0.8996704817, green: 0.8998214602, blue: 0.8996506333, alpha: 1)
        userName.layer.cornerRadius = 8
        view.addSubview(userName)
        
        email.textColor = .black
        email.placeholder = " Email"
        email.frame = CGRect(x: view.frame.width/6, y: view.frame.height/3+35, width: 280, height: 30)
        email.backgroundColor = #colorLiteral(red: 0.8996704817, green: 0.8998214602, blue: 0.8996506333, alpha: 1)
        email.layer.cornerRadius = 8
        view.addSubview(email)
        
        password.textColor = .black
        password.placeholder = " Password"
        password.frame = CGRect(x: view.frame.width/6, y: view.frame.height/2 - 85, width: 280, height: 30)
        password.backgroundColor = #colorLiteral(red: 0.8996704817, green: 0.8998214602, blue: 0.8996506333, alpha: 1)
        password.isSecureTextEntry = true
        password.layer.cornerRadius = 8
        view.addSubview(password)
        
        signUp.frame = CGRect(x: view.frame.width/4, y: view.frame.height/2-20, width: 200, height: 30)
        signUp.layer.cornerRadius = 8
        signUp.setTitle("Sign Up", for: .normal)
        signUp.backgroundColor = #colorLiteral(red: 0.02345971204, green: 0.03930909559, blue: 0.5252719522, alpha: 0.8470588235)
        signUp.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        view.addSubview(signUp)
        
        logInLabel.text = "Already have an account?"
        logInLabel.textColor = .black
        logInLabel.frame = CGRect(x: view.frame.width/8, y: view.frame.height/2+90, width: 280, height: 30)
        view.addSubview(logInLabel)
        
        logIn.frame = CGRect(x: view.frame.width/2 + 40, y: view.frame.height/2+90, width: 80, height: 30)
        logIn.layer.cornerRadius = 8
        logIn.setTitle("Login", for: .normal)
        logIn.setTitleColor( #colorLiteral(red: 0.02345971204, green: 0.03930909559, blue: 0.5252719522, alpha: 0.8470588235) , for: .normal)
        logIn.backgroundColor = #colorLiteral(red: 0.8996704817, green: 0.8998214602, blue: 0.8996506333, alpha: 1)
        logIn.addTarget(self, action: #selector(logInButtonClicked), for: .touchUpInside)
        view.addSubview(logIn)
        
    }
}

