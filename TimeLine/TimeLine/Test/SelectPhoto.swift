protocol PhotoSelectViewControllerDelegate: class {
    
    func photoSelectViewControllerSelected(_ image: UIImage)
}

import UIKit

class SelectPhoto: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func SelectPhotoBtn(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) -> Void in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) -> Void in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        
//        if let image = info[UIImagePickerController] as? UIImage {
//            
//            delegate?.photoSelectViewControllerSelected(image)
//            addphoto.setTitle("", for: UIControl.State())
//            imageView.image = image
//        }
//    }
    weak var delegate: PhotoSelectViewControllerDelegate?

    @IBOutlet weak var addphoto: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
}
