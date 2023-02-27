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
            loginViewModel.returnLogin(email: emailText!, password: passwordText!) { result in
                switch result {
                case .success(let data):
                    if data.status == 200 {
                        // Utilisez les données du packageData ici
                        if (data.employer.employer_email == emailText &&
                            data.employer.employer_password == passwordText
                        ) {
                            DispatchQueue.main.sync {
                                self.errorLabel.isHidden = true
                                let nextController = DeliverersViewController()
                                self.navigationController?.pushViewController(nextController, animated: true)
                            }
                        }
                    } else {
                        DispatchQueue.main.sync {
                            self.errorLabel.isHidden = true
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.sync {
                        self.errorLabel.text = "Network error : \(error)"
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
