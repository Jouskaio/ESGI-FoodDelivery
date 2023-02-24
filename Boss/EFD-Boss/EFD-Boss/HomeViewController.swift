//
//  HomeViewController.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 22/02/2023.
//

import UIKit
import NSLoggerSwift

class HomeViewController: UIViewController {

    // Variables
    let loginViewModel = ManageLogin()
    var response: [LoginDetails] = [];
    
    // Storyboard
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBAction func loginButton(_ sender: Any) {
        let passwordText = passwordField.text
        let emailText = emailField.text
        if ((emailText != nil) && (passwordText != nil)) {
            // Do something
            loginViewModel.returnLogin(email: emailText!, password: passwordText!) { login in
                if login.status == 200 {
                    // Utilisez les données du packageData ici
                    if (login.login.employer_email == emailText &&
                        login.login.employer_password == passwordText
                    ) {
                        let nextController = DeliverersViewController()
                        self.navigationController?.pushViewController(nextController, animated: true)
                    }
                } else {
                    Logger.shared.log(.routing, .error, "Error: \(login.error ?? "Unknown error")")
                    self.errorLabel.isHidden = false
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
}
