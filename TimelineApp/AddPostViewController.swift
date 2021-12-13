//
//  AddPostViewController.swift
//  TimelineApp
//
//  Created by Ebtesam Alahmari on 10/12/2021.
//

import UIKit
import Firebase

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var contentTxt: UITextView!
    @IBOutlet weak var userImg: UIImageView!
    let img = UIImageView()
    
    let imagePicker = UIImagePickerController()
    let db = Firestore.firestore()
    var userId = Auth.auth().currentUser?.uid
    var name = ""
    var userName = ""
    var userIcon = ""
    var imageName = "\(UUID().uuidString).png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        contentTxt.delegate = self
        contentTxt.isScrollEnabled = false
        contentTxt.text = "What's happening?"
        contentTxt.textColor = UIColor.lightGray
        userImg.layer.cornerRadius = userImg.frame.width/2
    }
    override func viewWillAppear(_ animated: Bool) {
        getUser()
    }
    
    @IBAction func addPostPressed(_ sender: Any) {
        addPost()
        let vc = storyboard?.instantiateViewController(withIdentifier: "tabBarID") as! UITabBarController
        present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func addPhotoPressed(_ sender: Any) {
        img.frame = CGRect(x: contentTxt.frame.minY, y: contentTxt.frame.maxY, width: 180, height: 180)
        img.contentMode = .scaleAspectFill
        view.addSubview(img)
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func addPost() {
        uploadImage()
        db.collection("Posts").addDocument(
            data: ["name": name,
                   "userName": userName ,
                   "postDate": Date(),
                   "userIcon": userIcon,
                   "postImage": imageName,
                   "message": contentTxt.text!
                  ]
        )
        {(error) in
            if let error = error {
                print("Error: ",error.localizedDescription)
            }else {
                print("new post has created..")
            }
        }
        
    }
    
    func getUser()  {
        if let userId = userId {
            db.collection("Users").document(userId).getDocument{ documentSnapshot, error in
                if let error = error {
                    print("Error: ",error.localizedDescription)
                }else {
                    self.name = documentSnapshot?.get("name") as? String ?? "nil"
                    self.userName = documentSnapshot?.get("userName") as? String ?? "nil"
                    let imgStr = documentSnapshot?.get("userIcon") as? String ?? "nil"
                    self.userIcon = imgStr
                    self.getImage(imgStr: imgStr)
                }
            }
        }
    }
    
    func getImage(imgStr: String) {
        let url = "gs://timelineapp-8d435.appspot.com/images/" + "\(imgStr)"
        let Ref = Storage.storage().reference(forURL: url)
        Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("Error: Image could not download!")
            } else {
                self.userImg.image = UIImage(data: data!)
            }
        }
    }
    
    
    func uploadImage()  {
        let imagefolder = Storage.storage().reference().child("images")
        if let imageData = img.image?.jpegData(compressionQuality: 0.1) {
            imagefolder.child(imageName).putData(imageData, metadata: nil){
                (metaData , err) in
                if let error = err {
                    print(error.localizedDescription)
                    
                }else {
                    print("تم رفع الصورة بنجاح")
                }
            }
        }
    }
    
}

//MARK: -UITextViewDelegate
extension AddPostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = contentTxt.sizeThatFits(size)
        contentTxt.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentTxt.textColor == UIColor.lightGray {
            contentTxt.text = nil
            contentTxt.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTxt.text.isEmpty {
            contentTxt.text = "What's happening?"
            contentTxt.textColor = UIColor.lightGray
        }
    }
}


//MARK: -UIImagePickerController
extension AddPostViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        img.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
}


