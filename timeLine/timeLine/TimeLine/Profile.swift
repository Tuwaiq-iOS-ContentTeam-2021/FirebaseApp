//
//  Profile.swift
//  timeLine
//
//  Created by nouf on 10/12/2021.
//

import UIKit
import Firebase

class Profile: UIViewController {
    @IBOutlet weak var tableViwe: UITableView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    
    let imageName = "\(UUID().uuidString).png"
    var linkImage = ""
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    var userName = ""
    var post = [PostStruct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViwe.dataSource = self
        tableViwe.delegate = self
        
        imageUser.layer.cornerRadius = imageUser.bounds.size.height / 2
        imageUser.layer.masksToBounds = true
        imageUser.image = UIImage(systemName: "person.circle")
        imageUser.contentMode = .scaleToFill
        let name = db.collection("Users").whereField( "email", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener{(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    self.userName = data["Name"] as! String
                    self.nameUser.text = "Name : \(self.userName)"
                    self.emailUser.text = "Email : \(Auth.auth().currentUser!.email!)"
                    let x = data["imageProfile"] as! String
                    self.imageUser.image =  UIImage(named: "\(x)")
                }
            }
        }
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        loadPost()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableViwe.reloadData()
    }
    
    
    @IBAction func uploudImage(_ sender: Any) {
        pickPhoto()
    }
    
    
    @IBAction func saveImage(_ sender: Any) {
        uploudimage()
    }
    // MARK: - log Out
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try  Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch  {
            print (error.localizedDescription)
        }
    }
    
    
    
    // MARK: - load data from the cloud
    
    
    
    
    
    func loadPost(){
        
        
        
        post.removeAll()
        
        
        db.collection("TimeLine").order(by: "date").whereField("userID", isEqualTo: userID!  ).addSnapshotListener{(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.post.removeAll()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    self.post.append(PostStruct(userName:data["userName"] as? String  ?? " ", userID:data["userID"] as! String  , post: data[ "post"] as? String  ?? " ", image:data["Image"] as? String  ?? " " ))
                }
                
                DispatchQueue.main.async {
                    self.tableViwe.reloadData()
                    
                }
            }
            
        }
        
        
    }
    
    func uploudimage(){
        
        let imageFolder = Storage.storage().reference().child("images")
        if let imageData = imageUser.image?.jpegData(compressionQuality: 0.1) {
            imageFolder.child(imageName).putData(imageData, metadata: nil)
            { (querySnapshot, err) in
                if let err = err {
                    print("Error : \(err.localizedDescription)")
                } else {
                    print("Is uploud" )
                    self.db.collection("Users").whereField( "email", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener{(querySnapshot, err) in
                        if let err = err {
                            print("Error : \(err)")
                        } else {
                            
                            for document in querySnapshot!.documents {
                                
                                let document = querySnapshot!.documents.first
                                document?.reference.updateData([
                                    "imageProfile" : "\(self.imageName)"
                                    
                                ])
                                self.linkImage = document!.get("imageProfile") as! String
                                self.getImage(name: self.linkImage)
                            }
                        }
                    }
                    
                    
                }
                
            }
            
            
        }
        
        
    }
    
    
    func getImage(name : String) {
        let url = "gs://timeline-60415.appspot.com/images/\(name)"
        let storageRef = Storage.storage().reference(forURL: url)
        
        storageRef.getData(maxSize: 2 * 1024 * 1024) { (data, error) in
            if error == nil {
                self.imageUser.image = UIImage(data:  data!)
                
                
            } else {
                print("ERROR DOWNLOADING IMAGE : \(String(describing: error))")
            }
        }
    }
    
    
}

extension  Profile : UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  post.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell2" , for: indexPath ) as! TableViewCell
        cell.name.text =  post[indexPath.row].userName
        cell.textContent.text = post[indexPath.row].post
        let name = post[indexPath.row].image
        cell.imageProfile.image = UIImage(named: name!)
        return cell
    }
    
}



extension Profile : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    // MARK:- Image Picker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageUser.image = pickedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    func pickPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    func showPhotoMenu() {
        let alert = UIAlertController(title: nil, message: nil,
                                      preferredStyle: .actionSheet)
        
        let actCancel = UIAlertAction(title: "Cancel", style: .cancel,
                                      handler: nil)
        alert.addAction(actCancel)
        
        let actPhoto = UIAlertAction(title: "Take Photo",
                                     style: .default, handler: nil)
        alert.addAction(actPhoto)
        
        let actLibrary = UIAlertAction(title: "Choose From Library",
                                       style: .default, handler: nil)
        alert.addAction(actLibrary)
        
        present(alert, animated: true, completion: nil)
    }
}

