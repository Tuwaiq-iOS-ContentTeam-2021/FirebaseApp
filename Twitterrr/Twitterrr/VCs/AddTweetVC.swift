//
//  AddTweetVC.swift
//  Twitterrr
//
//  Created by Taraf Bin suhaim on 06/05/1443 AH.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class AddTweetVC: UIViewController {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    let imagePicker = UIImagePickerController()
    var imageURL: String?
    var name = ""
    
    let yourTweetLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.57)
        lbl.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Your Tweet: characters Limit "
        return lbl
    }()
    
    let tweetTV: UITextView = {
        let tf = UITextView()
        tf.setupTextView()
        return tf
    }()
    
    let imageForTweet: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = 4
        btn.setupButton(using: "photo")
        
        return btn
    }()
    
    let tweetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setupButton(with: "Tweet")
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .TwitterBackground
        getUserName()
        setupPresenetationMode()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(yourTweetLbl)
        view.addSubview(tweetTV)
        view.addSubview(imageForTweet)
        view.addSubview(tweetButton)
        tweetTV.delegate = self
        imageForTweet.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        tweetButton.addTarget(self, action: #selector(sendTweet), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            yourTweetLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            yourTweetLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            yourTweetLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yourTweetLbl.heightAnchor.constraint(equalToConstant: 35),
            
            tweetTV.topAnchor.constraint(equalTo: yourTweetLbl.bottomAnchor, constant: 0),
            tweetTV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tweetTV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tweetTV.heightAnchor.constraint(equalToConstant: 80),
            
            imageForTweet.topAnchor.constraint(equalTo: tweetTV.bottomAnchor, constant: 15),
            imageForTweet.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageForTweet.heightAnchor.constraint(equalToConstant: 34),
            imageForTweet.widthAnchor.constraint(equalToConstant: 34),
            
            tweetButton.topAnchor.constraint(equalTo: imageForTweet.bottomAnchor, constant: 5),
            tweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tweetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tweetButton.heightAnchor.constraint(equalToConstant: 45),
            
            
            
        ])
    }
    private func setupPresenetationMode() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            presentationController.prefersGrabberVisible = true
        }
    }
    
    private func setupImagePicker() {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    @objc private func imageTapped() {
        print("Image tapped")
        setupImagePicker()
    }
    @objc private func sendTweet() {
        guard let userNewText = tweetTV.text else {return}
        guard let currentUser = Auth.auth().currentUser else {return}
        db.collection("Tweets").addDocument(data: [
            "TweetId" : UUID().uuidString,
            "timeStamp" : Date().timeIntervalSince1970,
            "TweetBody" : userNewText,
            "senderId" : currentUser.uid,
            "imageURL": imageURL ?? "",
            "name": name
        ]) { (error) in
            if let e = error {
                print("There was an issue saving data to firestore, \(e)")
            } else {
                print("Successfully saved data.")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    private func getUserName()  {
        
        db.collection("Profiles").document(Auth.auth().currentUser!.uid).getDocument { document, error in
            if let document = document, document.exists {
                let dataDescription = document.data()
                if let name = dataDescription!["name"] as? String {
                    self.name = name
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
}

extension AddTweetVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let d: Data = userPickedImage.jpegData(compressionQuality: 0.5) else { return }
        guard let currentUser = Auth.auth().currentUser else {return}
        
        
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        let ref = storage.reference().child("UserTweetImages/\(currentUser.email!)/\(currentUser.uid)/\(UUID()).jpg")
        
        ref.putData(d, metadata: metadata) { (metadata, error) in
            if error == nil {
                ref.downloadURL(completion: { (url, error) in
                    self.imageURL = "\(url!)"
                })
            }else{
                print("error \(String(describing: error))")
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension AddTweetVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        yourTweetLbl.text = "Your Tweet: characters Limit " + "80/" + "\(updatedText.count - 1)"
        return updatedText.count <= 80
    }
}
