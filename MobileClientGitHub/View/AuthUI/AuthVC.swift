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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func changeAction(_ sender: Any) {
        signUp = !signUp
    }
    @IBAction func loginAction(_ sender: Any) {
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
