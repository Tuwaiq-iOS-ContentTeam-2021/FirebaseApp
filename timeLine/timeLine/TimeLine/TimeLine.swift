//
//  TimeLine.swift
//  timeLine
//
//  Created by nouf on 09/12/2021.
//

import UIKit
import Firebase

class TimeLine: UIViewController {
    
    
    @IBOutlet weak var tableViwe: UITableView!
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    var post = [PostStruct]()
    var userName =  ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViwe.dataSource = self
        tableViwe.delegate = self
        
        let name = db.collection("Users").whereField( "email", isEqualTo: user?.email as Any).addSnapshotListener{(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    self.userName = data["Name"] as! String
                    print("dsa , " , self.userName)
                    
                }
            }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        loadPost()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableViwe.reloadData()
    }
    
    
    
    // MARK: - log Out
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try  Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch  {
            print (error.localizedDescription)
        }
    }
    
    
    
    // MARK: - load data from the cloud
    func loadPost(){
        
        
        post.removeAll()
        db.collection("TimeLine").order(by: "date").addSnapshotListener{(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.post.removeAll()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    self.post.append(PostStruct(userName:data["userName"] as! String  , userID:data["userID"] as! String  , post: data[ "post"] as? String  ?? " ", image:data["Image"] as? String  ?? " " ))
                }
                
                DispatchQueue.main.async {
                    self.tableViwe.reloadData()
                    
                }
            }
            
        }
        
    }
    
    
    
}

// MARK: - table View

extension  TimeLine: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  post.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell" , for: indexPath ) as! TableViewCell
        cell.name.text = post[indexPath.row].userName
        cell.textContent.text = post[indexPath.row].post
        let name = post[indexPath.row].image
        cell.imageProfile.image = UIImage(named: name!)
        
        return cell
    }
    
    
    
    
}




struct PostStruct {
    var userName  : String
    var userID : String
    var post : String?
    var image : String?
    var date = Date.now
    init(userName  : String , userID : String , post : String? , image: String?) {
        self.userName  = userName
        self.userID = userID
        self.post = post
        self.image = image
    }
}
