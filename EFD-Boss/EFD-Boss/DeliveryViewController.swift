//
//  DeliveryViewController.swift
//  EFD-Boss
//
//  Created by Elsa on 20/02/2023.
//

import UIKit

class DeliveryViewController: UIViewController {
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var title_page: UILabel!
    @IBOutlet var assigned_package: UILabel!
    
    @IBOutlet var employer_table: UITableView!
    @IBOutlet var package_table: UITableView!
    @IBAction func button_submit(_ sender: UIButton) {
        let createViewController = CreateDeliveryViewController(nibName: "CreateDeliveryViewController", bundle: nil)
        createViewController.employer_id = employer_id
        createViewController.modalPresentationStyle = .fullScreen
        self.present(createViewController, animated: true, completion: nil)
    }
    
    var employers: [Employer] = []
    var packages: [UnassignedPackage] = []
    var employer_id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.image = UIImage(named: "Logo")
        title_page.font = UIFont.boldSystemFont(ofSize: 30.0)
        title_page.text = "Liste des livreurs"
        title_page.numberOfLines = 0
        assigned_package.text = "Colis assignés"
        
        self.employer_table.dataSource = self
        self.employer_table.delegate = self
        self.employer_table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.package_table.dataSource = self
        self.package_table.delegate = self
        self.package_table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        returnAllEmployers()
    }
    
    private func returnAllEmployers() {
        let employerViewModel = ManageEmployerViewModel()
        employerViewModel.allEmployers { result in
            switch result {
            case .success(let data):
                self.employers = data.employer
                DispatchQueue.main.async {
                    self.employer_table.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func returnPackageEmployer(idEmployer: String) {
        let packageViewModel = ManagePackageViewModel()
        packageViewModel.returnPackageEmployer(idEmployer: idEmployer){ result in
            switch result {
            case .success(let data):
                self.packages = data.package
                DispatchQueue.main.async {
                    self.package_table.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}

extension DeliveryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == employer_table {
            return employers.count
        } else {
            return packages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == employer_table {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let employer = employers[indexPath.row]
            cell.textLabel?.text = "\(employer.employer_firstname) \(employer.employer_name)"
            cell.textLabel?.numberOfLines = 0
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let package = packages[indexPath.row]
            cell.textLabel?.text = "\(package.package_name)\nVille de livraison: \(package.package_destination_city)"
            cell.textLabel?.numberOfLines = 0
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == employer_table {
            let employer = employers[indexPath.row]
            returnPackageEmployer(idEmployer: String(describing:employer.id) )
            employer_id = String(describing:employer.id)
        } else {
            let package = packages[indexPath.row]
            // Traiter la sélection d'une cellule
        }
    }
}
