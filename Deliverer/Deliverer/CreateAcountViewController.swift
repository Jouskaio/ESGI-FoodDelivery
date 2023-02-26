//
//  CreateAcountViewController.swift
//  Deliverer
//
//  Created by Maaz TAGELDIN on 22/02/2023.
//

import UIKit

class CreateAcountViewController: UIViewController {

    
    @IBOutlet weak var firstnameTextField: UITextField!
    
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let employerViewModel = ManageEmployerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    
    @IBAction func signUpClicked(_ sender: UIButton) {
            guard let firstName = firstnameTextField.text, !firstName.isEmpty else {
                print("Veuillez saisir un prénom valide.")
                return
            }
            guard let lastName = lastnameTextField.text, !lastName.isEmpty else {
                print("Veuillez saisir un nom de famille valide.")
                return
            }
            guard let email = emailTextField.text, !email.isEmpty else {
                print("Veuillez saisir une adresse e-mail valide.")
                return
            }
            guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
                print("Veuillez saisir un numéro de téléphone valide.")
                return
            }
            guard let passWord = passwordTextField.text, !phoneNumber.isEmpty else {
                print("Veuillez saisir un mot de passe valide.")
                return
            }
        employerViewModel.createEmployer(employer_firstname: firstName, employer_name: lastName, employer_email: email, employer_phone: email, employer_password: passWord) { result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            let destinationVC = PackageTableViewController()
                            self.navigationController?.pushViewController(destinationVC, animated: true) }
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }

    }
    
   /* @objc func goToDestinationPage() {
        let destinationVC = CreateAcountViewController()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }*/
    
}
