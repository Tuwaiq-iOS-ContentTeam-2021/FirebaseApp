//
//  SignUpVC.swift
//  Timeline App
//
//  Created by Abdullah AlRashoudi on 12/10/21.
//

import UIKit
import Firebase
class SignInVC: UIViewController {
    //MARK: - Properties
    let appName = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let showPasswordButton = UIButton()
    let forgotPasswordButton = UIButton()
    let loginButton = UIButton()
    let lineView = UIView()
    let signUpLabel = UILabel()
    let signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        //MARK: - AppName
        appName.text = "Timeline App"
        appName.textColor = #colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1)
        appName.frame = CGRect(x: 100, y: 50, width: 240, height: 50)
        appName.font = .systemFont(ofSize: 40, weight: .semibold)
        view.addSubview(appName)
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
        //MARK: - HidePasswordButton
        showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showPasswordButton.tintColor = .gray
        showPasswordButton.frame = CGRect(x: 360, y: 287, width: 60, height: 60)
        showPasswordButton.addTarget(self, action: #selector(hidePassword), for: .touchUpInside)
        view.addSubview(showPasswordButton)
        //MARK: - ForgotPasswordButton
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(.systemBlue, for: .normal)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        forgotPasswordButton.frame = CGRect(x: 240, y: 330, width: 170, height: 40)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        view.addSubview(forgotPasswordButton)
        //MARK: - LoginButton
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(#colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1), for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.9411765933, green: 0.9411765337, blue: 0.9411766529, alpha: 1)
        loginButton.layer.cornerRadius = 15
        loginButton.frame = CGRect(x: 20, y: 400, width: 388, height: 34)
        loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(loginButton)
        //MARK: - SeparatorLine
        lineView.backgroundColor = #colorLiteral(red: 0.9411765933, green: 0.9411765337, blue: 0.9411766529, alpha: 1)
        lineView.frame = CGRect(x: 0 , y: 850, width: view.frame.size.width, height: 3)
        view.addSubview(lineView)
        //MARK: - SignUpLabel
        signUpLabel.text = "You don't have an account?"
        signUpLabel.font = .systemFont(ofSize: 17, weight: .regular)
        signUpLabel.frame = CGRect(x: 30, y: 850, width: 300, height: 60)
        signUpLabel.textAlignment = .center
        view.addSubview(signUpLabel)
        //MARK: - SignUpButton
        signUpButton.setTitle("SignUp", for: .normal)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        signUpButton.layer.cornerRadius = 15
        signUpButton.frame = CGRect(x: 280, y: 863, width: 80, height: 34)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        view.addSubview(signUpButton)
    }
    //MARK: - Methods
    @objc func hidePassword() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func forgotPassword() {
        
        let vc = ForgotPassVC()
        present(vc, animated: true, completion: nil)
    }
    
    @objc func login() {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {  authResult, error in
            
            if error == nil {
                
                let tabBarVC = UITabBarController()
                let vc1 = UINavigationController(rootViewController: HomeVC())
                let vc2 = UINavigationController(rootViewController: PostVC())
                let vc3 = UINavigationController(rootViewController: ProfileVC())
                
                vc1.title = "Home"
                vc2.title = "My Post"
                vc3.title = "Profile"
                
                tabBarVC.setViewControllers([vc1,vc2,vc3], animated: false)
                
                guard let items = tabBarVC.tabBar.items else {return}
                
                let images = ["house","note.text","person.crop.circle"]
                
                for i in 0..<items.count {
                    items[i].image = UIImage(systemName: images[i])
                }
                
                tabBarVC.tabBar.backgroundColor = .white
                tabBarVC.tabBar.tintColor = #colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1)
                tabBarVC.modalPresentationStyle = .fullScreen
                self.present(tabBarVC, animated: true, completion: nil)
                
                
            } else {
                print(error!.localizedDescription)
            }
            
        }
    }
    
    @objc func signUp() {
        
        let vc = SignUpVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
} // end of class

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
