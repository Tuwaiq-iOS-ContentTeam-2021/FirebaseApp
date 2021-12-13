//
//  HomeVC.swift
//  FirebaseApp
//
//  Created by Ahmad MacBook on 10/12/2021.
//

import UIKit
import Firebase


class HomeVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var arrUser : [getData] = []
    let db = Firestore.firestore()
    
    let refreshControl = UIRefreshControl()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getUserData()
        
        refreshControl.attributedTitle = NSAttributedString()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        refreshControl.endRefreshing()
    }
    
    func getUserData(){
        
        db.collection("Posts").order(by: "date")
            .getDocuments{ (snapshot, error) in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                }else {
                    
                    self.arrUser.removeAll()
                    
                    for document in snapshot!.documents {
    
                        let data = getData(name: document.get("name") as! String , description: document.get("post") as! String)
                        
                        self.arrUser.append(data)
                        
                    }
                    self.tableView.reloadData()
                    
                }
            }
    }
    
    
    
    
    @objc func refresh(_ sender: AnyObject) {
        getUserData()
        refreshControl.endRefreshing()
    }
    
    
}




extension HomeVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        
        arrUser.reverse()
        cell.testText.text = arrUser[indexPath.row].name
        cell.testText2.text = arrUser[indexPath.row].description
        arrUser.reverse()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
}


struct getData {
    
    var name : String
    var description : String
    
}

