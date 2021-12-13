//
//  WelcomeVC.swift
//  Twitterrr
//
//  Created by Taraf Bin suhaim on 06/05/1443 AH.
//

import UIKit
import FirebaseAuth

class WelcomeVC: UIViewController {

    let illustrationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pdfIllustr")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
      let title = UILabel()
        title.backgroundColor = .clear
        title.text = "Welcome To Timeline App"
        title.font = UIFont.systemFont(ofSize: 39, weight: .bold)
        title.textColor = .label
        title.textAlignment = .center
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let subTitleLabel: UILabel = {
      let subTitle = UILabel()
        subTitle.backgroundColor = .clear
        subTitle.text = "Join us."
        subTitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subTitle.textColor = .label.withAlphaComponent(0.75)
        subTitle.textAlignment = .center
        subTitle.numberOfLines = 0
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        return subTitle
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with: "Sign up")
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOG IN", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .TwitterBackground
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isUserSignedIn() {
            self.dismiss(animated: true, completion: nil)
        }
       
    }
    
    private func setupViews() {
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(sigUpButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        view.addSubview(illustrationImage)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(signUpButton)
        
        
        NSLayoutConstraint.activate([
        
            loginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 25),
            loginButton.widthAnchor.constraint(equalToConstant: 55),
        
            
            illustrationImage.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 5),
            illustrationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            illustrationImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            illustrationImage.heightAnchor.constraint(equalToConstant: 400),
            
            titleLabel.topAnchor.constraint(equalTo: illustrationImage.bottomAnchor, constant: 2),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            signUpButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 30),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 45),
        ])
        

    }
    
    @objc private func loginButtonTapped() {
        self.navigationController?.pushViewController(LoginVC(), animated: true)
        print("hello????")
    }
    @objc private func sigUpButtonTapped() {
        
        self.navigationController?.pushViewController(CreateAccountVC(), animated: true)
    }
    private func isUserSignedIn() -> Bool {
      return Auth.auth().currentUser != nil
    }
}
