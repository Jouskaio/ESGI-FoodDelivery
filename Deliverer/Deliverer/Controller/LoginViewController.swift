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

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func LoginClicked(_ sender: UIButton) {
        func loginClicked(_ sender: UIButton) {
            guard let email = emailTextField.text, !email.isEmpty else {
                print("Veuillez saisir une adresse e-mail valide.")
                return
            }
            guard let password = passwordTextField.text, !password.isEmpty else {
                print("Veuillez saisir un mot de passe valide.")
                return
            }
            employerViewModel.connexion(employer_email: email, employer_password: password) { result in
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

       /* guard let email = emailTextField.text else {return }
        guard let password = passwordTextField.text else {return }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("error")
            }
            else {
                // Go to home screen
                self.performSegue(withIdentifier: "GoToNext", sender: self)
            }
        }*/
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
