//
//  HomeVC.swift
//  TimelineApp
//
//  Created by TAGHREED on 07/05/1443 AH.
//

import UIKit
import Firebase

struct tvContent {
    var userImg = UIImage(systemName: "person")
    var name : String
    var user : String
    var tweet : String
    
}//1
class HomeVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var arr = [tvContent]()//2
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.user.text = "@\(arr[indexPath.row].user)"
        cell.name.text = arr[indexPath.row].name
        cell.textArea.text = arr[indexPath.row].tweet//3
        cell.contentView.layer.cornerRadius = 40
       
        return cell
    }
    
    let db = Firestore.firestore()
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var homeButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        homeButtonOutlet.isEnabled = false
        readData()
        //print(arr.count)
       
    }
    override func viewDidAppear(_ animated: Bool) {
        tv.reloadData()
        
    }
    
    @IBAction func AddButton(_ sender: Any) {
   let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContentVCid") as! ContentVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func AccountButton(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountVCid") as! AccountVC
             vc.modalPresentationStyle = .fullScreen
             present(vc, animated: true, completion: nil)
             
    }
    
    func readData() {
        
        
        
        db.collection("TimeLine").getDocuments { (qurySnapshot, error) in
            
            if let error = error {
                print(error)
                
                
            }else{
                for doc in qurySnapshot!.documents {
                    
                    let data = doc.data()
                    
                    print(data["name"]as? String ?? "name")
                    print(data["UserId"]as? String ?? "no UserId")
                    print(data["tweet"]as? String ?? "no tweet")
                    
                    
                    
                    self.arr.append(tvContent(name: data["name"]as? String ?? "no name", user: data["UserId"]as? String ?? "no UserId", tweet: data["tweet"]as? String ?? "no tweet"))
                    //print(self.arr.count)
                    self.tv.reloadData()
                    
                }
            }
        }
    }
    
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
