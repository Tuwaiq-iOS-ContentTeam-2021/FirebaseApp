//
//  ProfileVC.swift
//  Timeline
//
//  Created by Najla Talal on 12/10/21.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
            image.layer.cornerRadius = image.frame.height / 2
        image.contentMode = .scaleAspectFill
//        image.layer.cornerRadius = image.frame.height / 2
//        image.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
 

    
}
