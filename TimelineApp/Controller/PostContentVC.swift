//
//  PostContentVC.swift
//  TimelineApp
//
//  Created by WjdanMo on 10/12/2021.
//

import UIKit
import Firebase

class PostContentVC: UIViewController{

    let text = UITextField()
    let post = UIButton()
    let dismiss = UIButton()
    let postImage = UIButton()
    
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func uploadText(){
        
        if let text = text.text, let id = Auth.auth().currentUser?.uid {
            
            let messageData = ["Sender": id ,
                               "Content" : text,
                               "Date": Date().timeIntervalSince1970] as [String : Any]
            
            
            db.collection("Posts").addDocument(data: messageData) { error in
                if let error = error{
                    print("erorrrr", error.localizedDescription)
                }
                else{
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func postImageButtonClicked(){
        PostImageVC().modalPresentationStyle = .fullScreen
        present(PostImageVC(), animated: true, completion: nil)
    }
    
    
    func setup(){
        
        view.backgroundColor = .white
        text.textColor = .black
        text.placeholder = " whats up?"
        text.frame = CGRect(x: 20, y: view.frame.height/8 + 20 , width: view.frame.width - 40, height: 300)
        text.backgroundColor = #colorLiteral(red: 0.8996704817, green: 0.8998214602, blue: 0.8996506333, alpha: 1)
        text.layer.cornerRadius = 8
        view.addSubview(text)
        
        post.frame = CGRect(x: view.frame.width - 100, y: 80, width: 80, height: 30)
        post.layer.cornerRadius = 8
        post.setTitle("post", for: .normal)
        post.backgroundColor = #colorLiteral(red: 0.02345971204, green: 0.03930909559, blue: 0.5252719522, alpha: 0.8470588235)
        post.addTarget(self, action: #selector(uploadText), for: .touchUpInside)
        view.addSubview(post)
        
        dismiss.frame = CGRect(x: 20, y: 60, width: 50, height: 50)
        dismiss.setImage(UIImage(systemName: "xmark"), for: .normal)
        dismiss.tintColor = #colorLiteral(red: 0.02345971204, green: 0.03930909559, blue: 0.5252719522, alpha: 0.8470588235)
        dismiss.backgroundColor = .clear
        dismiss.addTarget(self, action: #selector(uploadText), for: .touchUpInside)
        view.addSubview(dismiss)
        
        postImage.frame = CGRect(x: view.frame.width/2-25, y: view.frame.height/2, width: 50, height: 50)
        postImage.layer.cornerRadius = 8
        postImage.setImage(UIImage(systemName: "photo"), for: .normal)
        postImage.tintColor = .white
        postImage.backgroundColor = #colorLiteral(red: 0.02345971204, green: 0.03930909559, blue: 0.5252719522, alpha: 0.8470588235)
        postImage.addTarget(self, action: #selector(postImageButtonClicked), for: .touchUpInside)
        view.addSubview(postImage)
    }
}

