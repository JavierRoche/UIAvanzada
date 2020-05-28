//
//  ViewsProvider.swift
//  AppDiscourseDesigned
//
//  Created by APPLE on 22/05/2020.
//  Copyright © 2020 Javier Roche. All rights reserved.
//

import UIKit

class TabBarProvider {
    private var tabBar: UITabBarController = UITabBarController()
    
    public func activeTab() -> UITabBarController {
        return tabBar
    }
    
    public func start() -> UITabBarController {
        let topicsViewController: TopicsViewController = TopicsViewController()
        let usersViewController: UsersViewController = UsersViewController()
        
        topicsViewController.tabBarItem = UITabBarItem.init(title: "Topics", image: UIImage(named: "inicio"), tag: 0)
        usersViewController.tabBarItem = UITabBarItem.init(title: "Users", image: UIImage(named: "usuarios"), tag: 1)

        let topicsNavigationController: UINavigationController = UINavigationController.init(rootViewController: topicsViewController)
        let usersNavigationController: UINavigationController = UINavigationController.init(rootViewController: usersViewController)

        tabBar.viewControllers = [topicsNavigationController, usersNavigationController]
        tabBar.tabBar.barStyle = .default
        tabBar.tabBar.isTranslucent = false
        tabBar.tabBar.tintColor = .black
        tabBar.tabBar.barTintColor = .white246

        if let tabBarItems: [UITabBarItem] = tabBar.tabBar.items {
            tabBarItems[0].title = "Topics"
            tabBarItems[0].selectedImage = UIImage(named: "inicio")
            tabBarItems[0].image = UIImage(named: "inicioUnselected")
            tabBarItems[1].title = "Users"
            tabBarItems[1].selectedImage = UIImage(named: "usuarios")
            tabBarItems[1].image = UIImage(named: "usuariosUnselected")
        }
        return tabBar
    }
}
    

//convenience init(index: Int) {
//    self.init()
//
//    let topicsViewController: TopicsViewController = TopicsViewController()
//    let usersViewController: UsersViewController = UsersViewController()
//
//    topicsViewController.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: ""), tag: 0)
//    usersViewController.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: ""), tag: 1)
//
//    let topicsNavigationController: UINavigationController = UINavigationController.init(rootViewController: topicsViewController)
//    let usersNavigationController: UINavigationController = UINavigationController.init(rootViewController: usersViewController)
//
//    let tabBar: UITabBarController = UITabBarController()
//    tabBar.viewControllers = [topicsNavigationController, usersNavigationController]
//    tabBar.tabBar.barStyle = .default
//    tabBar.tabBar.isTranslucent = false
//    tabBar.tabBar.tintColor = .black
//    tabBar.tabBar.barTintColor = .white246
//    tabBar.selectedIndex = index
//
//    if let tabBarItems: [UITabBarItem] = tabBar.tabBar.items {
//        tabBarItems[0].title = "Topics"
//        tabBarItems[0].selectedImage = UIImage(named: "inicio")
//        tabBarItems[0].image = UIImage(named: "inicioUnselected")
//        tabBarItems[1].title = "Users"
//        tabBarItems[1].selectedImage = UIImage(named: "usuarios")
//        tabBarItems[1].image = UIImage(named: "usuariosUnselected")
//    }
//}
