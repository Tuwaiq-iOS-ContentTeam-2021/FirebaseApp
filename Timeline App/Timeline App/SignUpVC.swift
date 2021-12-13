//
//  SignUpVC.swift
//  Timeline App
//
//  Created by Abdullah AlRashoudi on 12/11/21.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    //MARK: - Properties
    let lineView = UIView()
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
    let pageName = UILabel()
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signUpButton = UIButton()
    let backButton = UIButton()
    let signInLabel = UILabel()
    let signInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //MARK: - BackButton
        let largeBoldChevron = UIImage(systemName: "chevron.backward", withConfiguration: largeConfig)
        backButton.setImage(largeBoldChevron, for: .normal)
        backButton.frame = CGRect(x: 0, y: 50, width: 50, height: 50)
        backButton.tintColor = #colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1)
        backButton.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
        view.addSubview(backButton)
        //MARK: - PageName
        pageName.text = "Registration App"
        pageName.textColor = #colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1)
        pageName.frame = CGRect(x: 60, y: 50, width: 310, height: 50)
        pageName.font = .systemFont(ofSize: 40, weight: .semibold)
        view.addSubview(pageName)
        //MARK: - NameTextField
        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.frame = CGRect(x: 20, y: 200, width: 388, height: 34)
        view.addSubview(nameTextField)
        //MARK: - EmailTextField
        emailTextField.placeholder = "Enter your email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.frame = CGRect(x: 20, y: 250, width: 388, height: 34)
        view.addSubview(emailTextField)
        //MARK: - PasswordTextField
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.frame = CGRect(x: 20, y: 300, width: 388, height: 34)
        view.addSubview(passwordTextField)
        //MARK: - SignUpButton
        signUpButton.setTitle("SignUp", for: .normal)
        signUpButton.setTitleColor(#colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1), for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.9411765933, green: 0.9411765337, blue: 0.9411766529, alpha: 1)
        signUpButton.layer.cornerRadius = 15
        signUpButton.frame = CGRect(x: 20, y: 350, width: 388, height: 34)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        view.addSubview(signUpButton)
        //MARK: - SeparatorLine
        lineView.backgroundColor = #colorLiteral(red: 0.9411765933, green: 0.9411765337, blue: 0.9411766529, alpha: 1)
        lineView.frame = CGRect(x: 0 , y: 850, width: view.frame.size.width, height: 3)
        view.addSubview(lineView)
        //MARK: - SignInLabel
        signInLabel.text = "Already have an account?"
        signInLabel.font = .systemFont(ofSize: 17, weight: .regular)
        signInLabel.frame = CGRect(x: 30, y: 850, width: 300, height: 60)
        signInLabel.textAlignment = .center
        view.addSubview(signInLabel)
        //MARK: - SignInButton
        signInButton.setTitle("SignIn", for: .normal)
        signInButton.setTitleColor(.systemBlue, for: .normal)
        signInButton.layer.cornerRadius = 15
        signInButton.frame = CGRect(x: 270, y: 863, width: 80, height: 34)
        signInButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        view.addSubview(signInButton)
        
    }
    //MARK: - Methods
    @objc func signUp() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            
            if error == nil {
                
                let alert = UIAlertController(title: "Alert", message: "The account has been created successfully", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    @objc func dismissPage() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func signIn() {
        let vc = SignInVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
