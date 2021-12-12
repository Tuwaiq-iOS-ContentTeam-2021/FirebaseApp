//
//  LoginVC.swift
//  Twitterrr
//
//  Created by Taraf Bin suhaim on 06/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginVC: UIViewController {

    let db = Firestore.firestore()
    
    let emailTF: UITextField = {
        let textField = UITextField()
        textField.setupTextField(with:  NSAttributedString(string: "Email",
                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.label.withAlphaComponent(0.5)]))
        
        return textField
    }()
    let passwordTF: UITextField = {
        let textField = UITextField()
        textField.setupTextField(with:  NSAttributedString(string: "Password",
                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.label.withAlphaComponent(0.5)]))
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with: "Log in")
        button.addTarget(self, action: #selector(loginUserTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .TwitterBackground
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(loginButton)
        
        emailTF.delegate        = self
        passwordTF.delegate     = self
        NSLayoutConstraint.activate([
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -240),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            
            
            passwordTF.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTF.heightAnchor.constraint(equalToConstant: 45),
            
            emailTF.bottomAnchor.constraint(equalTo: passwordTF.topAnchor, constant: -20),
            emailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTF.heightAnchor.constraint(equalToConstant: 45)
            
        ])
        
    }
    
    @objc private func loginUserTapped() {
        guard let email = emailTF.text else {return}
        guard let password = passwordTF.text else {return}
        print("clicked")
        if !email.isEmpty && !password.isEmpty {
            loginUsing(email: email, password: password)
        }else{
            let alert = UIAlertController(title: "Oops!", message: "please make sure email and password are not empty.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            present(alert, animated: true)
        }
        
    }
    
    private func loginUsing(email: String, password: String) {
        print("clicked")
        Auth.auth().signIn(withEmail: email, password: password) { results, error in
            
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .wrongPassword:
                    
                    let alert = UIAlertController(title: "Oops!", message: "you entered a wrong password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                case .invalidEmail:
                    
                    let alert = UIAlertController(title: "Oops!", message: "are sure you typed the email correctly?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                default:
                    
                    let alert = UIAlertController(title: "Oops!", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                }
            }else{
                guard let user = results?.user else {return}
                
                self.db.collection("Profiles").document(user.uid).setData([
                    "email": String(user.email!),
                    "userID": user.uid,
                ], merge: true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            
        }
    }

}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        passwordTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        return true
    }
}
