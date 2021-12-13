//
//  ProfileViewController.swift
//  SocialMediaApp
//
//  Created by Rayan Taj on 11/12/2021.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var changeImageButtonOutlet: UIButton!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    let db = Firestore.firestore()
    let currerntEmail = Auth.auth().currentUser!.email
    let imageFolderReference = Storage.storage().reference().child("profileImages")
    var tweetsArray : [Tweet] = []
    
    let imagePicker = UIImagePickerController()
    @IBOutlet var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeImageButtonOutlet.layer.cornerRadius = changeImageButtonOutlet.frame.height/2
        
        
        tableView.register(UINib(nibName: "ProfileTweetTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTweetTableViewCell")
        
        imagePicker.delegate = self
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        downloadImage()
        emailLabel.text = currerntEmail
        getTweets()
    }
    
    
    @IBAction func signoutButtonAction(_ sender: Any) {
        do {
            try         Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch  {
            
        }
    
    }
    

   
    @IBAction func changeProfleImage(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
           
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if let imageData = selectedImage.jpegData(compressionQuality: 0.1) {
                
                imageFolderReference.child("\(currerntEmail!)").putData(imageData, metadata: nil){
                    (metaData , err) in
                    if let error = err {
                        print(error.localizedDescription)
                    }else {
                        print("تم رفع الصورة بنجاح")
                    }
                }
            }
     
             profileImage.contentMode = .scaleAspectFit
            profileImage.image = selectedImage
         }

         dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func downloadImage(){
        
        let imageRefrence = imageFolderReference.child("\(currerntEmail!)")
        
        imageRefrence.getData(maxSize: 1 * 1024 * 1024) { data, error in
          
            if error != nil {

          } else {
            
            let image = UIImage(data: data!)
            self.profileImage.contentMode = .scaleAspectFill
            self.profileImage.image = image
              
          }
        }
 
    }
    
    func getTweets()  {
        
        tweetsArray.removeAll()
        
        db.collection("tweets")
            .whereField("email", isEqualTo: currerntEmail!)
            .getDocuments {      [self] QuerySnapshot, Error in
            
            
            if Error == nil{
                
                for document in QuerySnapshot!.documents {
              
                        let email = document.get("email")!
                        let content = document.get("tweetContent")!
                    
                        self.tweetsArray.append(Tweet(email: email as! String, content: content as! String , image: profileImage.image!))

                }
                
                self.tableView.reloadData()
            }else{
                
                print(Error?.localizedDescription ?? "" , "❎")
            }
            
            
        }
        
       
        
    }

    
    
}


extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTweetTableViewCell", for: indexPath) as!
        ProfileTweetTableViewCell
        
           tweetCell.tweetContent.text = tweetsArray[indexPath.row].content
          
           return tweetCell
        
    }
}



