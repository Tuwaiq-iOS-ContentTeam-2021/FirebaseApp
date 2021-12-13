//
//  ProfileVC.swift
//  Timeline App
//
//  Created by Abdullah AlRashoudi on 12/11/21.
//

import UIKit
import Firebase
class ProfileVC: UIViewController {
    //MARK: - Properties
    let storage = Storage.storage()
    let db = Firestore.firestore()
    let email = Auth.auth().currentUser!.email!
    let imageName = "\(Auth.auth().currentUser!.email!).png"
    let appName = UILabel()
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
    let signOutButton = UINavigationItem()
    let lineView = UIView()
    let profileImage = UIImageView()
    let emailLable = UILabel()
    let changeImageButton = UIButton()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        downloadImage()
        //MARK: - AppName
        appName.text = "Timeline App"
        appName.textColor = #colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1)
        appName.frame = CGRect(x: 135, y: 40, width: 240, height: 50)
        appName.font = .systemFont(ofSize: 25, weight: .semibold)
        view.addSubview(appName)
        //MARK: - SignOutButton
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let largeBoldArrow = UIImage(systemName: "rectangle.portrait.and.arrow.right", withConfiguration: largeConfig)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: largeBoldArrow, style: .plain, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1)
        //MARK: - SeparatorLine
        lineView.backgroundColor = #colorLiteral(red: 0.9411765933, green: 0.9411765337, blue: 0.9411766529, alpha: 1)
        lineView.frame = CGRect(x: 0 , y: 90, width: view.frame.size.width, height: 3)
        view.addSubview(lineView)
        //MARK: - ProfileImage
        profileImage.image = UIImage(systemName: "person.crop.circle")
        profileImage.frame = CGRect(x: 160, y: 100, width: 100, height: 100)
        profileImage.tintColor = #colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1)
        profileImage.setRounded()
        view.addSubview(profileImage)
        //MARK: - EmailLabel
        emailLable.text = email
        emailLable.textColor = #colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1)
        emailLable.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 50)
        emailLable.font = .systemFont(ofSize: 25, weight: .semibold)
        emailLable.textAlignment = .center
        view.addSubview(emailLable)
        //MARK: - ChangeImage
        imagePicker.delegate = self
        changeImageButton.setTitle("Update Profile Photo", for: .normal)
        changeImageButton.setTitleColor(#colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1), for: .normal)
        changeImageButton.backgroundColor = #colorLiteral(red: 0.9411765933, green: 0.9411765337, blue: 0.9411766529, alpha: 1)
        changeImageButton.layer.cornerRadius = 15
        changeImageButton.frame = CGRect(x: 110, y: 250, width: 200, height: 34)
        changeImageButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        changeImageButton.addTarget(self, action: #selector(changePhoto), for: .touchUpInside)
        view.addSubview(changeImageButton)
    }
    //MARK: - Methods
    @objc func signOut() {
        
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Log Out", style: .destructive) { action in
            
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func changePhoto() {
        
        let alert = UIAlertController(title: "Alert", message: "Add Photo", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Take A Photo", style: .default) { action in
            let camera = UIImagePickerController()
            camera.sourceType = .camera
            camera.delegate = self
            self.present(camera, animated: true)
            self.uploadImage()
            
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Choose From Album", style: .default) { action in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
            self.uploadImage()
        })
        present(alert, animated: true, completion: nil)
        
    }
    
    func uploadImage(){
        let imagesFolder = storage.reference().child("images")
        if let imageData = profileImage.image?.jpegData(compressionQuality: 0.1){
            imagesFolder.child(imageName).putData(imageData, metadata: nil) { metaData, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Your image has been uploaded")
                    
                }
            }
        }
    }
    func downloadImage() {
        
        let timeLineRef = storage.reference().child("images").child(imageName)
        
        timeLineRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                self.profileImage.image = UIImage(data: data!)
                print("Your image has been downloaded")
            }
        }
        
    }
}
// MARK: - Extensions
extension UIImageView {
    
    func setRounded() {
        
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        profileImage.image = image
    }
}
