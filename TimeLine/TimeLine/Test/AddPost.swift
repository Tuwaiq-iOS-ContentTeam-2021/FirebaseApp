

import UIKit
import Firebase

class AddPost: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

  
    }

    @IBAction func add(_ sender: Any) {
        
    }
    var image: UIImage?
    
    @IBOutlet weak var comment: UITextField!
}
extension AddPost : PhotoSelectViewControllerDelegate {
    
    func photoSelectViewControllerSelected(_ image: UIImage) {
        
        self.image = image
    }
}
