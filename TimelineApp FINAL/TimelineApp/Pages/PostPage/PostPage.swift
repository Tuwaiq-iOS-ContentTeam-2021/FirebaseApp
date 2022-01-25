

import UIKit
import Firebase

class PostPage: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var userImage: UIImageView!
    
    let db = Firestore.firestore() // refrence
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    // to firebase
    @IBAction func newpost(_ sender: Any) {
        db.collection("Post").addDocument(data: [
            "email" : Auth.auth().currentUser?.email,
            "words": textView.text,
        ]){ (error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                print("Decument has been created")
                
            }
        }
    }
    
    //----------------------------------------
    
    // upload image to firebase
    func uploadImage(){
        let imageName = "\(UUID().uuidString).png"
        let imagefolder = Storage.storage().reference().child("images")
        
        if let imageData = userImage.image?.jpegData(compressionQuality: 0.1){ // compress image
            imagefolder.child(imageName).putData(imageData, metadata: nil){ // upload image
                (metaData , err) in
                if let error = err {
                    print(error.localizedDescription)
                }else{
                    print("** Image uploaded sucssefuly **")
                }
            }
        }
    }
    //----------------------------------------
    
    // camera
    @IBAction func camera(_ sender: Any) {
        let cameraView = UIImagePickerController()
        cameraView.delegate = self
        cameraView.sourceType = .camera
        present(cameraView, animated: true, completion: nil)
    }
    
    // images from library
    @IBAction func imageAction(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            userImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    // hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
