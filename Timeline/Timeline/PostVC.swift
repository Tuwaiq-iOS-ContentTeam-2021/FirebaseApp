//
//  PostVC.swift
//  Timeline
//
//  Created by Najla Talal on 12/10/21.
//

import UIKit
import Firebase
class PostVC: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let firestoreURL = Firestore.firestore()
      let username = Auth.auth().currentUser?.displayName

  
    @IBOutlet weak var postTF: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        postTF.placeholder = "What's happening ?"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func post(_ sender: Any) {
        
        firestoreURL.collection("Post")
                 .addDocument(data: [
                 "Post": postTF.text!,
                 "name": username
                 ])
        { (error) in
                  if let e = error {
                   print(e)
               
                  } else {
                      let vc = self.storyboard?.instantiateViewController(withIdentifier: "post") as! UITabBarController
                      self.present(vc, animated: true, completion: nil)
                   print("Successfully saved data")
                  }
                 }
     
             }
   
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        let cameraView = UIImagePickerController()
        cameraView.delegate = self
        cameraView.sourceType = .camera
        self.present(cameraView, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
           
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

