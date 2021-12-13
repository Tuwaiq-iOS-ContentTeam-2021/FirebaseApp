//
//  CreatePostVC.swift
//  Lola App
//
//  Created by Lola M on 12/12/21.
//

import UIKit


class CreatePostVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var txtPost: GrowingTextView!
    @IBOutlet weak var field: GrowingTextView!

    
    //    @IBOutlet  var btnPostBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        txtPost.layer.cornerRadius = 4.0
        txtPost.placeholder = "What's happening..."
        txtPost.font = UIFont.systemFont(ofSize: 18)
//        txtPost.minHeight = 20
//        txtPost.maxHeight = 300
        
        
        // *** Hide keyboard ***
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func tapGestureHandler() {
        view.endEditing(true)
    }
    
    @IBAction func btnCreatePostClicked() {
        
        if let text = self.txtPost.text {
            let currentDate = Date()
            let timeInterval = currentDate.timeIntervalSince1970
            
            let post : [AnyHashable : Any] = ["post" : text,
                                              "name" : FirebaseManager.shared.currentUserDisplayName,
                                              "imageUrl" : FirebaseManager.shared.currentUserImageUrl,
                                              "email" : FirebaseManager.shared.currentUser?.email ?? "dummy@dummy.com",
                                              "uid":FirebaseManager.shared.currentUser?.uid ?? 0,
                                              "timeIntervals": timeInterval]
            
            firebaseManager.addPost(post: post) { (ref, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnBackClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

extension CreatePostVC: GrowingTextViewDelegate {
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}


