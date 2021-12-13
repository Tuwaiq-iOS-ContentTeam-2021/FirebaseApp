//
//  LaunchScreen.swift
//  TwitterApp
//
//  Created by Nora on 06/05/1443 AH.
//

import UIKit

class LaunchScreen: UIViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(appImage)
       
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appImage.center = view.center
        view.backgroundColor = #colorLiteral(red: 0.6620503664, green: 0.728490293, blue: 0.6658555269, alpha: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
                        self.animate()
        })
    }
    
    
    // i did organized all views in Closures
    
    let appImage : UIImageView = {
        let myImage = UIImageView()
        myImage.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        myImage.image = UIImage(named: "Twitter")
        return myImage
    }()
    
    private func animate() {
        UIView.animate(withDuration: 3, animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.appImage.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
        })
        UIView.animate(withDuration: 1, animations: {
            self.appImage.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                    let MainPage =  MainPageVC()
                    MainPage.modalPresentationStyle = .fullScreen
                    self.present(MainPage, animated: true)
                })
            }
        })
 
}
}
