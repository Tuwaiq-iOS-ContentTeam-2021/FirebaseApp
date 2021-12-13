//
//  TimelineVC.swift
//  Timeline App
//
//  Created by mac on 11/12/2021.
//

import UIKit
import Firebase
class TimelineVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableTimeline: UITableView!
    
    let refreshControl = UIRefreshControl()
    let db = Firestore.firestore()
    var arrPosts:[Post] = []
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableTimeline.delegate = self
        tableTimeline.dataSource = self
        readData()
    
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableTimeline.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        arrPosts.removeAll()
        readData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableTimeline.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TimelineCell
        let list = self.arrPosts.sorted(by: {$0.date > $1.date })[indexPath.row]
        
        cell.dateLable.text = dateFormatterFunction(list.date)
        cell.contentLable.text = arrPosts[indexPath.row].post
        cell.usernameLable.text = arrPosts[indexPath.row].auther
        return cell
    }
    
    func readData(){
        
        db.collection("Users").getDocuments { (snapshot, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
                
            }else {
                
                for doc in snapshot!.documents {
                    
                    print(doc.get("post")!)

                    let data = Post(auther: doc.get("Auther") as! String, post: doc.get("post") as! String, date: doc.get("date") as! String)
            self.arrPosts.append(data)
                    
                }
                self.tableTimeline.reloadData()
                
            }
        }
    }
    
    func dateFormatterFunction(_ date: String) -> String {
        if let myTimeInterval: TimeInterval = TimeInterval(date) {
            let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
            print("here Time",time)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:ss a"
        
            return dateFormatter.string(from: time as Date)
        }
        
        return ""
    }
    
 
}

struct Post {
    let auther: String
    let post: String
    let date: String
}
