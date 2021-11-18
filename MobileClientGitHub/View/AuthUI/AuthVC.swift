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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        passwordTextField.delegate = self
        Defaults().defaults.set(["out" : 0], forKey: "entryStatus")

        // Do any additional setup after loading the view.
    }
    

    @IBAction func changeAction(_ sender: Any) {
        signUp = !signUp
    }
    
    @IBAction func loginAction(_ sender: Any) {
    }
    
    func alertForEmptyField(){
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
    }
    
    func alertUserIsRegistered(){
        let alert = UIAlertController(title: "Ошибка", message: "Пользователь с таким именем уже зарегистрирован", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
    }
    
    func alertUserIsNotRegistered(){
        let alert = UIAlertController(title: "Ошибка", message: "Пользователь с таким именем не зарегистрирован", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
    }
    

        
}


extension AuthVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = nameTextField.text!
        let password = passwordTextField.text!
        let contains = Auth().containsInUserDefaults(name: name)
            
        if (signUp){              //для регистрации
            
            if (!name.isEmpty && !password.isEmpty){
                if !contains{
                    auth.registration(name: name, password: password)
                    auth.changeStatus(entryStatus: true)
                }
                else{
                    alertUserIsRegistered()
                }
            }
            else{
                alertForEmptyField()
            }
        }
        else{                  //для входа
            
            if (!name.isEmpty && !password.isEmpty){
                if !contains{
                    alertUserIsNotRegistered()
                }
                else{
                    auth.changeStatus(entryStatus: true)
                //делаем вход
                }
            }
            else{
                alertForEmptyField()
            }
        }
        return true
    }
}
