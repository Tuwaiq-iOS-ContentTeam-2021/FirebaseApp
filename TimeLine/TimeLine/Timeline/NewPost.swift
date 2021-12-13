
import UIKit
import Firebase

class NewPost: UIViewController {
    
    var username : String?
    let db = Firestore.firestore()
    @IBOutlet weak var taskText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    @IBAction func add(_ sender: Any) {
       
        if let newPost = taskText.text ,
           let postSender = Auth.auth().currentUser?.email{
//            ,
//           let phoneSender = Auth.auth().currentUser?.phoneNumber{
            db.collection("Users").addDocument(data: [
                "NewPost" : newPost,
                "Sender" : postSender, //?? phoneSender,
                "date" : Date().timeIntervalSince1970
            ])
            {(error) in
                if error == nil {
                    print("new decument has been created..")
                }else{
                    print(error?.localizedDescription)
                    DispatchQueue.main.async {
                        self.taskText.text = ""
                    }
                }
            }
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! UITabBarController
        self.present(vc, animated: true, completion: nil)
    }
}

