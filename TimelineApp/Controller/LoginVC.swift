//
//  ViewController.swift
//  TimelineApp
//
//  Created by WjdanMo on 09/12/2021.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    let welcomMsg = UILabel()
    let email = UITextField()
    let password = UITextField()
    let login = UIButton()
    let signupLabel = UILabel()
    let signup = UIButton()
    let resetPassword = UIButton()
    
    let signUpObj = SignUpLogInModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    @objc func loginButtonClicked(){
        // login
        if let email = email.text, let password = password.text{
            if signUpObj.logInAction(email, password){
                
                let vc = HomeVC()
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
                
            }
            else{
                let alertController = UIAlertController(title: "Wrong log In info ", message: "A standard alert.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    
                 }
                 alertController.addAction(cancelAction)
            }
        }
    }
    
    @objc func signUPButtonClicked(){
        self.performSegue(withIdentifier: K.navigateToSignUpVC , sender: nil)
    }
    
    @objc func resetPasswordButtonClicked(){
        performSegue(withIdentifier: K.navigateToResetPasswordVC , sender: nil)
    }
    
    func setup(){
        
        welcomMsg.text = "Login to Blink"
        welcomMsg.textColor = .black
        welcomMsg.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
        welcomMsg.frame = CGRect(x: 0, y: view.frame.height/5, width: view.frame.width, height: 50)
        welcomMsg.textAlignment = .center
        view.addSubview(welcomMsg)
        
        email.textColor = .black
        email.placeholder = " enter ur email"
        email.frame = CGRect(x: view.frame.width/6, y: view.frame.height/4+40, width: 280, height: 30)
        email.backgroundColor = #colorLiteral(red: 0.8996704817, green: 0.8998214602, blue: 0.8996506333, alpha: 1)
        email.layer.cornerRadius = 8
        view.addSubview(email)
        
        password.textColor = .black
        password.placeholder = " enter ur password"
        password.frame = CGRect(x: view.frame.width/6, y: view.frame.height/4+90, width: 280, height: 30)
        password.backgroundColor = #colorLiteral(red: 0.8996704817, green: 0.8998214602, blue: 0.8996506333, alpha: 1)
        password.isSecureTextEntry = true
        password.layer.cornerRadius = 8
        view.addSubview(password)
        
        login.frame = CGRect(x: view.frame.width/4, y: view.frame.height/2 - 80, width: 200, height: 30)
        login.layer.cornerRadius = 8
        login.setTitle("Login", for: .normal)
        login.backgroundColor = #colorLiteral(red: 0.02345971204, green: 0.03930909559, blue: 0.5252719522, alpha: 0.8470588235)
        login.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        view.addSubview(login)
        
        signupLabel.text = "Don't have an account?"
        signupLabel.textColor = .black
        signupLabel.frame = CGRect(x: view.frame.width/6, y: view.frame.height/2, width: 280, height: 30)
        view.addSubview(signupLabel)
        
        signup.frame = CGRect(x: view.frame.width/2 + 40, y: view.frame.height/2 , width: 80, height: 30)
        signup.layer.cornerRadius = 8
        signup.setTitle("Sign Up", for: .normal)
        signup.setTitleColor( #colorLiteral(red: 0.02345971204, green: 0.03930909559, blue: 0.5252719522, alpha: 0.8470588235) , for: .normal)
        signup.backgroundColor = .white
        signup.addTarget(self, action: #selector(signUPButtonClicked), for: .touchUpInside)
        view.addSubview(signup)
        
        resetPassword.frame = CGRect(x: view.frame.width/4, y: view.frame.height/2+50, width: 200, height: 30)
        resetPassword.layer.cornerRadius = 8
        resetPassword.setTitle("forgot password?", for: .normal)
        resetPassword.setTitleColor(#colorLiteral(red: 0.02345971204, green: 0.03930909559, blue: 0.5252719522, alpha: 0.8470588235), for: .normal)
        resetPassword.backgroundColor = #colorLiteral(red: 0.8996704817, green: 0.8998214602, blue: 0.8996506333, alpha: 1)
        resetPassword.addTarget(self, action: #selector(resetPasswordButtonClicked), for: .touchUpInside)
        view.addSubview(resetPassword)
        
        
    }
    
}

