//
//  ProfileVC.swift
//  Twitterrr
//
//  Created by Taraf Bin suhaim on 06/05/1443 AH.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class ProfileVC: UIViewController {
    let db = Firestore.firestore()
    let imagePicker = UIImagePickerController()
    let storage = Storage.storage()
    
    
    
    
    let profileImage: UIImageView = {
        let pI = UIImageView()
        pI.contentMode = .scaleAspectFit
        pI.clipsToBounds = true
        pI.layer.cornerRadius = 80
        pI.layer.borderColor = UIColor.white.cgColor
        pI.layer.borderWidth = 1
        return pI
    }()
    
    let userNameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        name.textColor = .label
        name.textAlignment = .center
        
        return name
    }()
    
    
    let userEmailLabel: UILabel = {
        let email = UILabel()
        email.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        email.textAlignment = .center
        email.textColor = .label
        return email
    }()
    
    let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(with: "Sign out")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .TwitterBackground
        title = "Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        readImageFromFirestore()
        setUpLabels()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCurrentUsers()
    }
    
    
    
    
    
    func setUpLabels() {
        
        
        
        profileImage.tintColor  = .white
        profileImage.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImage.addGestureRecognizer(tapRecognizer)
        
        
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileImage)
        view.addSubview(userNameLabel)
        view.addSubview(signOutButton)
        view.addSubview(userEmailLabel)
        
        profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 160).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 160).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        userNameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        
        
       
       
        userEmailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 3).isActive = true
        
       
        
        signOutButton.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 20).isActive = true
        signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
    }
    
    @objc func signOutButtonTapped() {
        do{
            try Auth.auth().signOut()
            self.tabBarController?.selectedIndex = 0
            print("ChangedUserStatus")
        }catch  {
            print("error logining out user.")
        }
    }
    
    func setupImagePicker() {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    @objc func imageTapped() {
        print("Image tapped")
        setupImagePicker()
    }
    
    func saveImageToFirestore(url: String, userId: String) {
        
        db.collection("Profiles").document(userId).setData([
            "userImageURL": url,
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    private func readImageFromFirestore(){
        guard let currentUser = Auth.auth().currentUser else {return}
        
        db.collection("Profiles").whereField("email", isEqualTo: String(currentUser.email!))
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            
                            if let imageURL = data["userImageURL"] as? String
                            {
                                
                                let httpsReference = self.storage.reference(forURL: imageURL)
                                
                                
                                httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                    if let error = error {
                                        // Uh-oh, an error occurred!
                                        print("ERROR GETTING DATA \(error.localizedDescription)")
                                    } else {
                                        // Data for "images/island.jpg" is returned
                                        
                                        DispatchQueue.main.async {
                                            self.profileImage.image = UIImage(data: data!)
                                        }
                                        
                                    }
                                }
                                
                            } else {
                                
                                print("error converting data")
                                DispatchQueue.main.async {
                                    self.profileImage.image = UIImage(systemName: "person.fill.badge.plus")
                                }
                                
                            }
                            
                            
                        }
                    }
                }
            }
    }
    
    
    
    
    
    private func fetchCurrentUsers() {
        guard let currentUserName = FirebaseAuth.Auth.auth().currentUser else {return}
        db.collection("Profiles").whereField("email", isEqualTo: String(currentUserName.email!))
            .addSnapshotListener { (querySnapshot, error) in
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let userName = data["name"] as? String,
                               let userEmail = data["email"] as? String
                            {
                                
                                
                                DispatchQueue.main.async {
                                    self.userNameLabel.text = userName
                                    self.userEmailLabel.text = userEmail
                                    
                                }
                                
                                
                            }
                        }
                    }
                }
                
            }
    }
    
    
}


extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let d: Data = userPickedImage.jpegData(compressionQuality: 0.5) else { return }
        guard let currentUser = Auth.auth().currentUser else {return}
        
        
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        let ref = storage.reference().child("UserProfileImages/\(currentUser.email!)/\(currentUser.uid).jpg")
        
        ref.putData(d, metadata: metadata) { (metadata, error) in
            if error == nil {
                ref.downloadURL(completion: { (url, error) in
                    self.saveImageToFirestore(url: "\(url!)", userId: currentUser.uid)
                    
                })
            }else{
                print("error \(String(describing: error))")
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
    
    
    
    
    
