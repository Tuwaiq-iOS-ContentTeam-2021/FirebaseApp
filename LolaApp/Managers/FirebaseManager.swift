//
//  FirebaseManager.swift
//  Lola App
//
//  Created by Lola M on 12/12/21.
//

import Foundation
import Firebase
import SwiftUI

typealias FirebaseCompletion = (_ reference: DatabaseReference, _ error: Error?) -> Void
typealias FirebaseObserverCompletion = (_ key: String, _ value: Any) -> Void
typealias FirebaseStorageCompletion = (_ url: String, _ error: Error?) -> Void
typealias FirebaseKingdomExists = (_ exists: Bool) -> Void
typealias FirebaseGameStartStatus = (_ key: String, _ value: Bool ) -> Void
typealias FirebaseCoinsCount = (_ key: String, _ value: Double ) -> Void

class FirebaseManager: NSObject {
    

    var databaseQueryRef: DatabaseQuery?
    var databaseRef : DatabaseReference {
        return Database.database().reference()
    }
    
    var databaseSessionRef : DatabaseReference?
    var databaseSeessionRefHandle: DatabaseHandle?

    var databaseRefHandle: DatabaseHandle?
    var currentDeviceUniqueId : String = ""
    var currentUser: User? {
        return firebaseAuth.currentUser
    }
    
    var currentUserImageUrl = ""
    var currentUserDisplayName = ""
    
    static var shared = FirebaseManager()
    
    override fileprivate init() {
    }
    
    
    func authenticate(id:String, password:String, completion:AuthResultCallback? = nil) {
        firebaseAuth.signIn(withEmail: id, password: password, completion: { user, error in
            if let handler = completion{
                DispatchQueue.main.async {
                    handler(user?.user,error)
                }
            }
        })
        
    }
    
    
    
    func register(id:String, password:String, completion:AuthResultCallback? = nil) {
        firebaseAuth.createUser(withEmail: id, password: password, completion: { user, error in
            if let handler = completion{
                DispatchQueue.main.async {
                    handler(user?.user,error)
                }
            }
        })
    }
    
    
    
    func changeUserStatusForSignUp(post : [AnyHashable : Any], for userid: String, withCompletion handler: FirebaseCompletion? = nil) {

           Database.database().reference().child("Users").child(userid).updateChildValues(post)
           { (error, ref) in
               DispatchQueue.main.async {
                   handler?(ref, error)
               }
           }
       }
    
    
    
    func getUserInfo(forPerson: String, onUpdate: FirebaseObserverCompletion? = nil) {
        let databaseReference = Database.database().reference().child("Users").child(forPerson)
        databaseReference.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            var dict: [AnyHashable: Any] = [:]
            if let snapshotDict = snapshot.value as? [AnyHashable: Any]{
                dict = snapshotDict
            }
            if let handler = onUpdate {
                DispatchQueue.main.async {
                    handler(snapshot.key, dict)
                }
            }
        })
    }
    
    
    
    
    func addPost(post : [AnyHashable : Any], withCompletion handler: FirebaseCompletion? = nil) {
        
        self.databaseRef.child("Posts").childByAutoId().updateChildValues(post)
        { (error, ref) in
            DispatchQueue.main.async {
                handler?(ref, error)
            }
        }
    }
    
    

    func getPosts(onUpdate: FirebaseObserverCompletion? = nil) {

        self.databaseQueryRef = self.databaseRef.child("Posts")
        self.databaseRefHandle = self.databaseQueryRef?.observe(.value, with: { snapshot in
            if !snapshot.exists() { return }
            var dict: [AnyHashable: Any] = [:]
            if let snapshotDict = snapshot.value as? [AnyHashable: Any]{
                dict = snapshotDict
            }
            if let handler = onUpdate {
                DispatchQueue.main.async {
                    handler(snapshot.key, dict)
                }
            }
        })
    }
    
    
    
    func uploadImageToFirebaseStorage(imageName : String, imageToUpload : UIImage,  withCompletion handler: FirebaseStorageCompletion? = nil){
        var data = NSData()
        data = imageToUpload.jpegData(compressionQuality: 0.8)! as NSData
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        let storageRef = Storage.storage().reference().child("Users-Profile-Picture").child(imageName)
        storageRef.putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                storageRef.downloadURL(completion: { (url, error) in
                    if (url?.absoluteString) != nil {
                        DispatchQueue.main.async {
                            handler?(url?.absoluteString ?? "not available", error)
                        }
                    }
                })
            }
        }.observe(.progress) { (snapshot) in
            let progress = Float(snapshot.progress?.completedUnitCount ?? 0) / Float(snapshot.progress?.totalUnitCount ?? 1)
            var percent = Int(progress * 100.0)
            percent = (percent > 100) ? 100 : percent
        }
    }
    
}
