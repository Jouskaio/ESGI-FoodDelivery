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
    // Storyboard
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBAction func loginButton(_ sender: Any) {
        let passwordText = passwordField.text
        let emailText = emailField.text
        if ((emailText != nil) && (passwordText != nil)) {
            // If information are corrects, then proceed to access to the application
            loginViewModel.returnLogin(email: emailText!, password: passwordText!) { login in
                Logger.shared.log(.routing, .error, "Error: \(String(describing: login.status))")
                if login.status == 200 {
                    // Utilisez les données du packageData ici
                    if (login.employer_email == emailText &&
                        login.employer_password == passwordText
                    ) {
                        DispatchQueue.main.sync {
                            self.errorLabel.isHidden = true
                            let nextController = DeliverersViewController()
                            self.navigationController?.pushViewController(nextController, animated: true)
                        }
                    }
                } else {
                    Logger.shared.log(.routing, .error, "Error: \(login.error ?? "Unknown error")")
                    DispatchQueue.main.sync {
                        self.errorLabel.text = login.error ?? "Password or email incorrect"
                        self.errorLabel.isHidden = false
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
}
