//
//  HomeView.swift
//  TimeLineApp
//
//  Created by Abrahim MOHAMMED on 10/12/2021.
//

import UIKit
import Firebase
class HomeView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // struct type
    var arrData : [dataValue] = []
    
    var db = Firestore.firestore()
    
    let refreshControl = UIRefreshControl()

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = MyTableViewHome.dequeueReusableCell(withIdentifier: "cellHome") as! HomeTableViewCell
       
        cell.userNameLabel.text = arrData[indexPath.row].userName
        cell.descrabtionLable.text = arrData[indexPath.row].descrabtion
        return cell
    }
    
    
    
    
    @IBOutlet weak var MyTableViewHome: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        MyTableViewHome.delegate = self
        MyTableViewHome.dataSource = self
        
        getData()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           MyTableViewHome.addSubview(refreshControl)
       
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
       
        getData()
        refreshControl.endRefreshing()
    }
    
    func getData(){
        
        print(Auth.auth().currentUser?.email!)
        
        db.collection("users").getDocuments { (QuerySnapshot,error) in
            
            if error == nil {
                self.arrData.removeAll()
                for i in QuerySnapshot!.documents {
                    
                    var x  = dataValue(userName: i.get("userName") as! String, descrabtion: i.get("descrabtion")as! String)
                    
                    self.arrData.append(x)
                   
                    
                }
                self.arrData.reverse()
                self.MyTableViewHome.reloadData()
            } else {
                print(error?.localizedDescription)

            }
            
            
            
        }
        
         
        
    }
    
    



}


struct dataValue{
    
    var userName : String
    
    var descrabtion : String
    
    
}


