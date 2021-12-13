

import UIKit
import Firebase

class PostPage: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var userImage: UIImageView!
    var imagePath = "no image" //
    

    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid

    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }

    // post , set values to firebase
    @IBAction func post(_ sender: Any) {
        var s = SignInPage() //$$
        ref = Database.database().reference()
        var postMsg =
        [
            "userUID" : userID! ,
            "text" : textView.text!,
            "imagePath" : imagePath
        ]
        // childByAutoId() every time i create nod with diffrernt id
        ref.child("Posts").childByAutoId().setValue(postMsg)
        uploadImage() // to firebase
        var imagePath = "no image"
        performSegue(withIdentifier: "postToHome", sender: nil)
    }
    
    @IBAction func newpost(_ sender: Any) {
        // ^^^^^^^^^^^^^^^^^^^^^^^^^
        let db = Firestore.firestore() // refrence
//        let userID = Auth.auth().currentUser?.uid

        db.collection("Users")
            .document("user")
            .setData(
                [
                    "userID" : userID!,
                    "email" : Auth.auth().currentUser?.email,
                    "text" : textView.text!
                ]
            )
        {
            (error) in
            if error == nil{
                print("Decument has been created")
            } else{
                print(error?.localizedDescription)
            }
        }
        // ^^^^^^^^^^^^^^^^^^^^^^^^^
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
//            uploadImage(image: image)
    }
        dismiss(animated: true, completion: nil)
//        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
