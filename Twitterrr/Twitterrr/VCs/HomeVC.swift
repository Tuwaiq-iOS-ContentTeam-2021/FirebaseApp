//
//  HomeVC.swift
//  Twitterrr
//
//  Created by Taraf Bin suhaim on 06/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
class HomeVC: UIViewController {
    
    private let db = Firestore.firestore()
    private var collectionView: UICollectionView!
    private var tweets: [Tweet] = []
    private let storage = Storage.storage()
    private let addTweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 25
        button.setupButton(using: "pencil.and.outline")
        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupView()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isUserIsSignedIn() {
            showWelcomeScreen()
        }else{
            fetchMessages()
        }
       
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Home"
        
        view.addSubview(addTweetButton)
        addTweetButton.addTarget(self, action: #selector(addTweetButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
        
            addTweetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addTweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addTweetButton.heightAnchor.constraint(equalToConstant: 50),
            addTweetButton.widthAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    @objc private func addTweetButtonTapped() {
        let sheetViewController = AddTweetVC(nibName: nil, bundle: nil)
        self.present(sheetViewController, animated: true, completion: nil)
    }
    private func isUserIsSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    private func showWelcomeScreen() {
        let vc = UINavigationController(rootViewController: WelcomeVC())
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.id)
        collectionView.backgroundColor = UIColor.systemBackground
        view.addSubview(collectionView)
    }
    
    private func setupCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(280)),
            subitem: item, count: 1
        )
        
    
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        return UICollectionViewCompositionalLayout(section: section)
    }
    private func fetchMessages() {
       
        db.collection("Tweets")
            .addSnapshotListener { (querySnapshot, error) in
                self.tweets = []
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            
                            if let TweetBody    = data["TweetBody"] as? String,
                               let _            = data["TweetId"] as? String,
                               let imageURL     = data["imageURL"] as? String,
                               let name         = data["name"] as? String,
                               let _            = data["senderId"] as? String,
                               let timeStamp    = data["timeStamp"] as? Double
                            {
                                if imageURL != "" {
                                    let httpsReference = self.storage.reference(forURL: imageURL)
                                    httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                        if let error = error {
                                            print("ERROR GETTING DATA \(error.localizedDescription)")
                                        } else {
                                            
                                            let newTweet = Tweet(image: UIImage(data: data!)!, name: name, tweetBody: TweetBody, timeStamp: self.stringToDate(timeStamp))
                                            
                                            self.tweets.append(newTweet)
                                            DispatchQueue.main.async {
                                                self.collectionView.reloadData()
                                            }
                                        }
                                    }
                                }else{
                                    let newTweet = Tweet(image: nil, name: name, tweetBody: TweetBody, timeStamp: self.stringToDate(timeStamp))
                                    
                                    self.tweets.append(newTweet)
                                    DispatchQueue.main.async {
                                        self.collectionView.reloadData()
                                    }
                                }
                               
                                
                                
                                
                            } else {
                                print("error converting data. ")
                                return
                                
                            }
                            
                            
                        }
                    }
                }
            }
    }
    private func stringToDate(_ unixTimestamp: Double) -> String {
        
        let date = Date(timeIntervalSince1970: unixTimestamp)

        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }

}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.id, for: indexPath) as! TweetCell
        
        cell.tweetImage.image       = tweets[indexPath.row].image
        cell.tweetUserName.text     = tweets[indexPath.row].name
        cell.tweetText.text         = tweets[indexPath.row].tweetBody
        cell.tweetDate.text         = tweets[indexPath.row].timeStamp
        cell.tweetUserImage.image   = UIImage(systemName: "person.crop.circle.fill")!.withTintColor(UIColor.systemOrange, renderingMode: .alwaysOriginal)
        
        
        return cell
    }

    
}
