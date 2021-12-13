//
//  ForgotPassVC.swift
//  Timeline App
//
//  Created by Abdullah AlRashoudi on 12/10/21.
//

import UIKit
import Firebase
class ForgotPassVC: UIViewController {
    //MARK: - Properties
    let updatePasswordTextField = UITextField()
    let updatePasswordButton = UIButton()
    let resetButton = UIButton()
    let emailTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //MARK: - UpdatePasswordTextField
        updatePasswordTextField.placeholder = "Enter your new password"
        updatePasswordTextField.borderStyle = .roundedRect
        updatePasswordTextField.frame = CGRect(x: 20, y: 250, width: 388, height: 34)
        view.addSubview(updatePasswordTextField)
        //MARK: - UpdatePasswordButton
        updatePasswordButton.setTitle("Update", for: .normal)
        updatePasswordButton.setTitleColor(#colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1), for: .normal)
        updatePasswordButton.backgroundColor = #colorLiteral(red: 0.9411765933, green: 0.9411765337, blue: 0.9411766529, alpha: 1)
        updatePasswordButton.layer.cornerRadius = 15
        updatePasswordButton.frame = CGRect(x: 20, y: 300, width: 388, height: 34)
        updatePasswordButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        updatePasswordButton.addTarget(self, action: #selector(updatePassword), for: .touchUpInside)
        view.addSubview(updatePasswordButton)
        //MARK: - EmailTextField
        emailTextField.placeholder = "Enter your email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.frame = CGRect(x: 20, y: 350, width: 388, height: 34)
        view.addSubview(emailTextField)
        //MARK: - ResetPasswordButton
        resetButton.setTitle("Reset via link", for: .normal)
        resetButton.setTitleColor(#colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1), for: .normal)
        resetButton.backgroundColor = #colorLiteral(red: 0.9411765933, green: 0.9411765337, blue: 0.9411766529, alpha: 1)
        resetButton.layer.cornerRadius = 15
        resetButton.frame = CGRect(x: 20, y: 400, width: 388, height: 34)
        resetButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        resetButton.addTarget(self, action: #selector(resetLink), for: .touchUpInside)
        view.addSubview(resetButton)
    }
    //MARK: - Methods
    @objc func updatePassword() {
        Auth.auth().currentUser?.updatePassword(to: updatePasswordTextField.text!) { error in
            
            if error == nil {
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func resetLink() {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
            
            if error == nil {
                
                let alert = UIAlertController(title: "Alert", message: "The reset link has been send", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
                DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }
    }
    
}
