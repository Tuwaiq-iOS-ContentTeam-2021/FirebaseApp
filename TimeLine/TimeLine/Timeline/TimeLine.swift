
import UIKit
import Firebase

class TimeLine: UIViewController {
    
    @IBOutlet weak var tableT: UITableView!
    
    let db = Firestore.firestore()
    var taskArray = [Posts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableT.reloadData()
        loadData()
    }
    
    func loadData (){
        db.collection("Users")
            .order(by: "date")
            .addSnapshotListener {
                (qurySnashot , err ) in
                self.taskArray = []
                if let err = err {
                    print(err.localizedDescription)
                }else{
                    if let snapshotDocuments = qurySnashot?.documents {
                        for document in snapshotDocuments{
                            let data = document.data()
                            if let postSender = data ["NewPost"] as? String,
                               let postBody = data ["Sender"] as? String {
                                let newPost = Posts(Sender: postSender, Post: postBody)
                                self.taskArray.append(newPost)
                                DispatchQueue.main.async {
                                    self.tableT.reloadData()
                                    
                                    let indexPath = IndexPath(row: self.taskArray.count - 1, section: 0)
                                    self.tableT.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
    }
}


extension TimeLine : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableT.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellOfTable
        
        
        cell.userName.text = taskArray[indexPath.row].Post
        cell.cellLabel.text = taskArray[indexPath.row].Sender
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print (self.taskArray.remove(at: indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        }
    }
}


struct Posts {
    var Sender : String?
    var Post : String?
}
