//
//  ViewController.swift
//  MobileClientGitHub
//
//  Created by Sergey on 26.10.2021.
//

import UIKit


class RepositoryListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    
    
    var VM: RepositoryListVM!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.VM = .init(model: modelSingleton.repositoriesList, UI: self)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (VM.repositoryList?.count) ?? 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repositoryDetail"{
            let destination = segue.destination as! RepositoryDetailVC
            
            let model = (sender as! RepositoryViewCell).VM.model
            let VM = RepositoryDetailVM.init(model: model)
            destination.initialize(VM: VM)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "repositoryDetail", sender: tableView.cellForRow(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCustomCell") as! RepositoryViewCell
        
        let cellModel = VM.cellForRowAt(indexPath: indexPath)
        let cellVM = RepositoryCellVM.init(model: cellModel)
        cell.initialize(VM: cellVM)
        
        return cell
    }
}

