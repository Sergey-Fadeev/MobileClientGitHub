//
//  ViewController.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import UIKit
import Combine


class RepositoryListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var internetConnectionLabel: UILabel!
    var VM: RepositoryListVM!
    var repositoriesCancellable: Cancellable? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM = .init(model: modelSingleton.repositoriesList)
        userLogin = UserDefaults.standard.string(forKey: "user")!
        
        if Reachability.isConnectedToNetwork(){
            internetConnectionLabel.isHidden = true
        }
        else{
            internetConnectionLabel.isHidden = false
        }
        
        repositoriesCancellable = VM.$repositoryList.sink(receiveValue: {
            r in
            guard r != nil else {
                return
            }
            DispatchQueue.main.async {
                self.tableView.delegate = self
                self.tableView.register(UINib(nibName: "RepositoryViewCell", bundle: nil), forCellReuseIdentifier: "repositoryCustomCell")
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        })
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        userName.text = "   \(userLogin)"
    }
    
    @IBAction func logout(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registrationID")
        appDelegate.window?.rootViewController = rootController
    }
}


extension RepositoryListVC: UITableViewDelegate, UITableViewDataSource {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repositoryDetail"{
            let destination = segue.destination as! RepositoryDetailVC
            let model = (sender as! RepositoryViewCell).VM.model
            let VM = RepositoryDetailVM.init(model: model)
            destination.initialize(VM: VM)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (VM.repositoryList?.count) ?? 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "repositoryDetail", sender: tableView.cellForRow(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCustomCell") as! RepositoryViewCell
        let cellVM = VM.VMforRowAt(indexPath: indexPath)
        cell.initialize(VM: cellVM!)
        return cell
    }
}

