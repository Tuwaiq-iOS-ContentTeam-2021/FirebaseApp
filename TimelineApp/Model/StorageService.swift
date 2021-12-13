//
//  StorageService.swift
//  TimelineApp
//
//  Created by WjdanMo on 11/12/2021.
//

import Foundation
import UIKit
import FirebaseStorage

struct StorageService {
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        
        // 1
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return completion(nil)
        }

        // 2
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            // 3
            if let error = error {
                print(error.localizedDescription)
                return completion(nil)
            }

            // 4
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return completion(nil)
                }
                completion(url)
            })
        })
    }
}
