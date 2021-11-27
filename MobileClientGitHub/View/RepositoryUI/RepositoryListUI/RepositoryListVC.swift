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
    var viewModel: RepositoryListVM?
    var repositoriesCancellable: Cancellable? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.viewModel = .init(model: Model.shared.repositoriesList)
        userLogin = UserDefaults.standard.string(forKey: "user")!
        checkConnection()
        guard viewModel != nil else{return}
        repositoriesCancellable = viewModel!.$repositoryList.sink(receiveValue: {
            publisher in
            guard publisher != nil else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
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
    
    private func checkConnection(){
        if Reachability.isConnectedToNetwork(){
            internetConnectionLabel.isHidden = true
        }
        else{
            internetConnectionLabel.isHidden = false
        }
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.register(UINib(nibName: "RepositoryViewCell", bundle: nil), forCellReuseIdentifier: "repositoryCustomCell")
        tableView.dataSource = self
    }
}


extension RepositoryListVC: UITableViewDelegate, UITableViewDataSource {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repositoryDetail"{
            let destination = segue.destination as! RepositoryDetailVC
            guard viewModel != nil else{return}
            let model = (sender as! RepositoryViewCell).viewModel!.model
            let VM = RepositoryDetailVM.init(model: model)
            destination.initialize(VM: VM)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.repositoryList?.count) ?? 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "repositoryDetail", sender: tableView.cellForRow(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCustomCell") as! RepositoryViewCell
        let cellVM = viewModel?.VMforRowAt(indexPath: indexPath)
        guard cellVM != nil else{return cell}
        cell.initialize(VM: cellVM!)
        return cell
    }
}
