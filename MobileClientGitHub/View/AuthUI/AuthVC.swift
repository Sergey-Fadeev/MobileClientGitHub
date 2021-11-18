//
//  AuthVC.swift
//  MobileClientGitHub
//
//  Created by Sergey on 18.11.2021.
//

import Foundation
import UIKit

class AuthVC: UIViewController {
    
    var signUp:Bool = true {
        willSet{
            if newValue{
                titleLabel.text = "Регистрация"
                logInButton.setTitle("Зарегистрироваться", for: .normal)
                changeButton.setTitle("Уже есть аккаунт?", for: .normal)
            }
            else{
                titleLabel.text = "Вход"
                logInButton.setTitle("Войти", for: .normal)
                changeButton.setTitle("Зарегистрироваться?", for: .normal)
            }
        }
    }
    
    let auth = Auth()
    
    var alert = UIAlertController(title: "Ошибка", message: "I am an alert message you cannot dissmiss.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        Defaults().defaults.set(["entryStatus" : 0], forKey: "entryStatus")
        alert.addAction(ok)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func changeAction(_ sender: Any) {
        signUp = !signUp
    }
    
    @IBAction func loginAction(_ sender: Any) {
        logIn()
    }
    
    
    
    func logIn() {
        let name = nameTextField.text!
        let password = passwordTextField.text!
        let contains = Auth().containsInUserDefaults(name: name)
            
        if (signUp){              //для регистрации
            
            if (!name.isEmpty && !password.isEmpty){
                if !contains{
                    auth.registration(name: name, password: password)
                    auth.changeStatus(entryStatus: true)
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                        return
                    }
                    let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigation")
                    appDelegate.window?.rootViewController = rootController
                    userLogin = name
                    
                }
                else{
                    alertUserIsRegistered()
                }
            }
            else{
                alertForEmptyField()
                return
            }
        }
        else{                  //для входа
            
            if (!name.isEmpty && !password.isEmpty){
                if !contains{
                    alertUserIsNotRegistered()
                }
                else{
                    auth.changeStatus(entryStatus: true)
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                        return
                    }
                    let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigation")
                    appDelegate.window?.rootViewController = rootController
                    userLogin = name
                //делаем вход
                }
            }
            else{
                alertForEmptyField()
            }
        }
    }
    
    
    
    
    func alertForEmptyField(){
        alert.message = "Заполните все поля"
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertUserIsRegistered(){
        alert.message = "Пользователь с таким именем уже зарегистрирован"
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertUserIsNotRegistered(){
        alert.message = "Пользователь с таким именем не зарегистрирован"
        self.present(alert, animated: true, completion: nil)
    }
}
