
import UIKit



class CellOfTable: UITableViewCell {
    
    var indexPath:IndexPath!
    
    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var trash: UIButton!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var likebtn: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    var checkButtonState = false

    override func awakeFromNib() {
        super.awakeFromNib()
        profileimage.makeRounded()
    }

    @IBAction func islike(_ sender: Any) {
        
        if checkButtonState == false {
            likebtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            checkButtonState = true
        } else {
            likebtn.setImage(UIImage(systemName: "heart"), for: .normal)
            checkButtonState = false
        }
    }
}

extension UIImageView {

    func makeRounded() {

//        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
//        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
