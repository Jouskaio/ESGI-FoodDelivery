//
//  DeliveryViewController.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 27/02/2023.
//

import UIKit

class DeliveryViewController: UIViewController {

    @IBOutlet var logo: UIImageView!
    @IBOutlet var title_page: UILabel!
    @IBOutlet var assigned_package: UILabel!
    
    @IBOutlet var employer_table: UITableView!
    @IBOutlet var package_table: UITableView!
    @IBAction func button_submit(_ sender: UIButton) {
        if(pressionButtton == false){
            createDelivery(idEmployer: employer_id)
            pressionButtton = true
            sender.setTitle("Accéder à la tournée", for: .normal)
        } else {
            let createViewController = CreateDeliveryViewController(nibName: "CreateDeliveryViewController", bundle: nil)
            createViewController.employer_id = employer_id
            createViewController.delivery_id = delivery_id
            createViewController.modalPresentationStyle = .fullScreen
            self.present(createViewController, animated: true, completion: nil)
            pressionButtton = false
            sender.setTitle("Créer une tournée", for: .normal)
        }
    }
    @IBAction func see_delivery(_ sender: UIButton) {
        let specialViewController = SpecialDeliveryViewController(nibName: "SpecialDeliveryViewController", bundle: nil)
        specialViewController.employer_id = employer_id
        specialViewController.modalPresentationStyle = .fullScreen
        self.present(specialViewController, animated: true, completion: nil)
    }
    
    let employerViewModel = ManageEmployerViewModel()
    var employers: [Employer] = []
    let packageViewModel = ManagePackageViewModel()
    var packages: [UnassignedPackage] = []
    let deliveryViewModel = ManageDeliveryViewModel()
    
    var employer_id: String = ""
    var delivery_id: String = ""
    var pressionButtton: Bool = false
    
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
        packageViewModel.returnPackageEmployer(idEmployer: idEmployer){ result in
            switch result {
            case .success(let data):
                self.packages = data.package
                DispatchQueue.main.async {
                    self.package_table.reloadData()
                }
            case .failure(let error):
                self.packages = []
                DispatchQueue.main.async {
                    self.package_table.reloadData()
                }
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func createDelivery(idEmployer: String) {
        deliveryViewModel.createDelivery(idEmployer: idEmployer) { result in
            switch result {
            case .success(let data):
                self.delivery_id = String(describing:data.delivery)
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
        }
    }
}
