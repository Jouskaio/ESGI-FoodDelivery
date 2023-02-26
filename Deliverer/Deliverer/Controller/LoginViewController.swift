//
//  LoginViewController.swift
//  Deliverer
//
//  Created by Maaz TAGELDIN on 22/02/2023.
//

import UIKit
//import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let employerViewModel = ManageEmployerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func LoginClicked(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            print("Veuillez saisir une adresse e-mail valide.")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("Veuillez saisir un mot de passe valide.")
            return
        }
        employerViewModel.connexion(email: email, password: password) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let id_employer = data.employer.id
                    let destinationVC = PackageTableViewController()
                    destinationVC.idEmployer = id_employer
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
