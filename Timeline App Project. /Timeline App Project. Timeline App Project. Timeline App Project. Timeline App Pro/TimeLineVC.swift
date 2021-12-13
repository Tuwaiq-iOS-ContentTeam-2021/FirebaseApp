//
//  TimeLineVC.swift
//  Timeline App Project. Timeline App Project. Timeline App Project. Timeline App Pro
//
//  Created by Qahtani's MacBook Pro on 12/11/21.
//

import UIKit
import Firebase



class TimeLineVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    let db = Firestore.firestore()
    
    var postArry:[infoData] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArry.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTabelView.dequeueReusableCell(withIdentifier: "cell-id", for: indexPath) as! TimeLineCell
//        cell.myImage
        cell.UserName.text! = postArry[indexPath.row].userName
        cell.Describtion.text! = postArry[indexPath.row].contant
        cell.Date.text! = "2021-12-11"


        return cell
    }
    

    @IBOutlet weak var myTabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        myTabelView.dataSource = self
        myTabelView.delegate = self
        getData()
    
    }
    func getData(){
        db.collection("post").getDocuments { QuerySnapshot , error in
            
            
            for document in QuerySnapshot!.documents {
             var x = infoData(userName: document.get("emali") as! String, contant: document.get("post") as! String)
                
                self.postArry.append(x)
                
                
            }
            
            self.myTabelView.reloadData()
            
        
            
            if error == nil {
                print("Data Hear")
            }
            
            
        }
    }
    

   

}
struct infoData{
    var userName: String
    var contant:String
}
