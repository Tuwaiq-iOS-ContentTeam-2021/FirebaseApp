//
//  TwitterTabBar().swift
//  Twitterrr
//
//  Created by Taraf Bin suhaim on 06/05/1443 AH.
//

import UIKit


class TwitterTabBar: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
        
            barItem(tabBarTitle: "Home", tabBarImage: UIImage(systemName: "house.fill")!.withTintColor(UIColor.systemOrange, renderingMode: .alwaysOriginal), viewController: HomeVC()),
            barItem(tabBarTitle: "Profile", tabBarImage: UIImage(systemName: "person.fill")!.withTintColor(UIColor.systemOrange, renderingMode: .alwaysOriginal), viewController: ProfileVC()),
        
        ]
        tabBar.isTranslucent = true
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemOrange], for: .selected)
        tabBar.unselectedItemTintColor = .gray
    }
    

    private func barItem(tabBarTitle: String, tabBarImage: UIImage, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = tabBarTitle
        navigationController.tabBarItem.image = tabBarImage
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}



