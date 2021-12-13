//
//  ProfileVC.swift
//  TwitterApp
//
//  Created by Nora on 09/05/1443 AH.
//

import UIKit
import Firebase
import SwiftUI
class ProfileVC: UIViewController {

    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(profileImg)
        view.addSubview(emailLebel)
        view.addSubview(logoutBtn)
        emailLebel.text = user?.email
        emailLebel.frame = CGRect(x: 0 , y: 400, width: view.frame.width, height: 30)
    }
    
    
    // i did organized all views in Closures
    
    let profileImg : UIImageView = {
        let profileImg = UIImageView()
        profileImg.frame = CGRect(x: 120, y: 250, width: 150, height: 150)
        profileImg.image = UIImage(systemName: "person.fill")
        profileImg.tintColor = #colorLiteral(red: 0.1448850334, green: 0.2240020931, blue: 0.1941880286, alpha: 1)
        return profileImg
    }()
    
    let emailLebel : UILabel = {
        let emailLebel = UILabel()
//       emailLebel.frame = CGRect(x: 150 , y: 400, width: view.frame.width, height: 30)
        emailLebel.textAlignment = .center
        emailLebel.textColor = #colorLiteral(red: 0.1448850334, green: 0.2240020931, blue: 0.1941880286, alpha: 1)
        emailLebel.font = .boldSystemFont(ofSize: 20)
        return emailLebel
    }()

//    let passwordLebel : UILabel = {
//        let passwordLebel = UILabel()
//        passwordLebel.frame = CGRect(x: 110 , y: 350, width: 200, height: 30)
//        passwordLebel.textColor = .white
//        passwordLebel.font = .boldSystemFont(ofSize: 20)
//        return passwordLebel
//    }()
    
    let logoutBtn : UIButton = {
        let logoutBtn = UIButton()
        logoutBtn.frame = CGRect(x: 300, y: 70, width: 80, height: 30)
        logoutBtn.backgroundColor = #colorLiteral(red: 0.6620503664, green: 0.728490293, blue: 0.6658555269, alpha: 1)
        logoutBtn.setTitle("LogOut", for: .normal)
        logoutBtn.setTitleColor(.white, for: .normal)
        logoutBtn.layer.cornerRadius = 15
        logoutBtn.addTarget(self, action: #selector(louOut), for: .touchDown)
        return logoutBtn
    }()


    
    
    @objc func louOut(){
        
        let mainPageVC = MainPageVC()
        do{
            try Auth.auth().signOut()
            mainPageVC.modalPresentationStyle = .fullScreen
            self.present(mainPageVC, animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
  
}

