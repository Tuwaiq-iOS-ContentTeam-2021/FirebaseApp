//
//  HomeVC.swift
//  TimelineApp
//
//  Created by WjdanMo on 10/12/2021.
//

import UIKit
import SwiftUI
import Firebase

class HomeVC: UIViewController {
    
    let postContent = UIButton()
    
    let postsTableView = UITableView()
    
    var postsArray = [Post]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        postsTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellID)
        
        setup()
        loadPosts()
    }
    
    @objc func postContentButtonClicked(){
        
        let vc = PostContentVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
//        self.performSegue(withIdentifier: K.navigateToPostContentVC, sender: nil)
        
    }

    func loadPosts(){
        db.collection("Posts").order(by: "Date").addSnapshotListener{
            
            querySnapshot, error in
            
            self.postsArray = []
            
            if let error = error {
                print(error.localizedDescription)
            }
            else{
                if let snapshotDocs = querySnapshot?.documents{
                    for doc in snapshotDocs{
                        
                        let data = doc.data()
                        if let content = data["Content"] as? String  {
                            
                            let newPost = Post(postContent: content)
                            
                            self.postsArray.append(newPost)
                            
                            DispatchQueue.main.async {
                                self.postsTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setup(){
        
        view.backgroundColor = .white
        
        postContent.frame = CGRect(x: view.frame.width - 100, y: view.frame.height - 100, width: 60, height: 60)
        postContent.layer.cornerRadius = 8
        postContent.setImage(UIImage(systemName: "pencil"), for: .normal)
        postContent.tintColor = .white
        postContent.backgroundColor = #colorLiteral(red: 0.02345971204, green: 0.03930909559, blue: 0.5252719522, alpha: 0.8470588235)
        postContent.addTarget(self, action: #selector(postContentButtonClicked), for: .touchUpInside)
        view.addSubview(postContent)
        
        postsTableView.dataSource = self
        postsTableView.dataSource = self
        postsTableView.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: view.frame.height - 300)
        postsTableView.register(PostCell.self, forCellReuseIdentifier: K.cellID)
        view.addSubview(postsTableView)
        
    }
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellID, for: indexPath) as! PostCell
        
        cell.post.text = postsArray[indexPath.row].postContent
        
        // MARK: image post
//        cell.post.image = UIImage(named: "hi")
//        let imageUrl = postsArray[indexPath.row].imageURL
//        if let url = URL(string: imageUrl ){
//
//            URLSession.shared.dataTask(with: url) { data, _, error in
//                guard let data = data, error == nil else { return }
//
////                cell.post.image = UIImage(data: data)
//         }}

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}


