//
//  downloadImage.swift
//  timeLineApp
//
//  Created by Areej on 13/12/2021.
//

import Foundation
import UIKit

class imageService{
    static func downloadimage(withURL url:URL , completion: @escaping (_ image : UIImage?)->()){
        
        let datatask = URLSession.shared.dataTask(with: url){data, url, err in
            var downloadedimage:UIImage?
            if let data = data {
                downloadedimage = UIImage(data: data)
            }
            DispatchQueue.main.async {
                completion(downloadedimage)
            }
        }
        datatask.resume()
    }
}
