//
//  RepositoryDetailVC.swift
//  MobileClientGitHub
//
//  Created by Sergey on 12.11.2021.
//

import UIKit

class RepositoryDetailVC: UIViewController {

    @IBOutlet weak var imageOwner: UIImageView!
    @IBOutlet weak var nameOwner: UILabel!
    @IBOutlet weak var imageLanguage: UIImageView!
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
