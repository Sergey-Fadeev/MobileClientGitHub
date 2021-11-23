//
//  TabBarVC.swift
//  MobileClientGitHub
//
//  Created by Sergey on 23.11.2021.
//

import UIKit


class TabBarVC: UITabBarController {
    
    weak var firstTab: RepositoryListVC!
    weak var secondTab: FavoritesRepositoryListVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTab = (self.viewControllers![0] as! RepositoryListVC)
        secondTab = (self.viewControllers![1] as! FavoritesRepositoryListVC)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        firstTab.tableView.reloadData()
    }
}
