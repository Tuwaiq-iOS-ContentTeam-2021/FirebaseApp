//
//  ViewController.swift
//  TwitterApp
//
//  Created by Nora on 06/05/1443 AH.
//

import UIKit

class MainPageVC: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.6620503664, green: 0.728490293, blue: 0.6658555269, alpha: 1)
        view.addSubview(appImage)
        view.addSubview(newLebel)
        view.addSubview(createBtn)
        view.addSubview(logInLebel)
        view.addSubview(logInBtn)

    }
    
    
    // i did organized all views in Closures
    
    let appImage : UIImageView = {
        let appImage = UIImageView()
        appImage.frame = CGRect(x: 170 , y: 70, width: 50, height: 50)
        appImage.image = UIImage(named: "Twitter")
        return appImage
    }()
    
    let newLebel : UILabel = {
        let newLebel = UILabel()
        newLebel.frame = CGRect(x: 60 , y: 300, width: 300, height: 80)
        newLebel.text = "See what's happening in the world right now"
        newLebel.textColor = .white
        newLebel.numberOfLines = 2
        newLebel.font = .boldSystemFont(ofSize: 25)
        return newLebel
    }()
    
    let createBtn : UIButton = {
        let createBtn = UIButton()
        createBtn.frame = CGRect(x: 60 , y: 500, width: 250, height: 50)
        createBtn.setTitle("Create account", for: .normal)
        createBtn.setTitleColor(#colorLiteral(red: 0.6620503664, green: 0.728490293, blue: 0.6658555269, alpha: 1), for: .normal)
        createBtn.backgroundColor = .white
        createBtn.layer.cornerRadius = 20
        createBtn.addTarget(self, action: #selector(createAccount), for: .touchDown)
        return createBtn
    }()
    
    let logInLebel : UILabel = {
        let logInLebel = UILabel()
        logInLebel.frame = CGRect(x: 60 , y: 700, width: 200, height: 20)
        logInLebel.text = "Have an account already?"
        logInLebel.textColor = .gray
        logInLebel.font = .systemFont(ofSize: 15)
        return logInLebel
    }()
    
    let logInBtn : UIButton = {
        let logInBtn = UIButton()
        logInBtn.frame = CGRect(x: 240 , y: 700, width: 50, height: 20)
        logInBtn.setTitle("Log in", for: .normal)
        logInBtn.setTitleColor(.link, for: .normal)
        logInBtn.addTarget(self, action: #selector(login), for: .touchDown)
//      logInBtn.backgroundColor = .white
        return logInBtn

    }()
    
    
    
    
    @objc func createAccount() {
        
        let signUP =  SignUpVC()
        signUP.modalPresentationStyle = .fullScreen
        present(signUP, animated: true, completion: nil)
       
    }
    
    @objc func login() {
        
        let logIN = LoginVC()
        logIN.modalPresentationStyle = .fullScreen
        present(logIN, animated: true, completion: nil)
    }

}

