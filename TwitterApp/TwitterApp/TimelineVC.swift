//
//  TimelineVC.swift
//  TwitterApp
//
//  Created by Aisha Al-Qarni on 13/12/2021.
//

import UIKit
import Firebase

class TimelineVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var array: [Cell] = []
    @IBOutlet weak var TableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCells", for: indexPath) as! TimelineCell
        cell.username.text = array[indexPath.row].username
        cell.userImg.image = array[indexPath.row].userImg
        cell.tweet.text = array[indexPath.row].tweet
        cell.favorite = array[indexPath.row].isFavorute
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
struct Cell {
    var userImg: UIImage
    var username: String
    var tweet: String
    var isFavorute: Bool

}
