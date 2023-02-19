//
//  HomeViewController.swift
//  EFD-Boss
//
//  Created by Elsa on 10/02/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var logoView: UIImageView!
    @IBOutlet var package_deadline: UIView!
    @IBOutlet var package_table: UITableView!
    
    @IBOutlet var titlePage: UILabel!
    @IBOutlet var package_name: UILabel!
    @IBOutlet var package_weight: UILabel!
    @IBOutlet var package_recovery: UILabel!
    @IBOutlet var destination_number: UILabel!
    @IBOutlet var destination_street: UILabel!
    @IBOutlet var destination_zip: UILabel!
    @IBOutlet var destination_city: UILabel!
    @IBOutlet var package_note: UILabel!
    @IBOutlet var package_date_deadline: UILabel!
    @IBOutlet var package_sender: UILabel!
    
    let packageViewModel = ManagePackageViewModel()
    var unassignedPackages: [UnassignedPackage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoView.image = UIImage(named: "Logo")
        titlePage.font = UIFont.boldSystemFont(ofSize: 30.0)
        titlePage.text = "Colis \n non assignés"
        titlePage.numberOfLines = 0
        package_name.font = UIFont.boldSystemFont(ofSize: 25.0)
        package_deadline.layer.borderWidth = 1
        package_deadline.layer.borderColor = UIColor.orange.cgColor
        
        self.package_table.dataSource = self
        self.package_table.delegate = self
        self.package_table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        packageViewModel.unassignedPackage { result in
            switch result {
            case .success(let data):
                self.unassignedPackages = data.package
                DispatchQueue.main.async {
                    self.package_table.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func returnSpecialPackage(idPackage: String) {
        let packageViewModel = ManagePackageViewModel()
        packageViewModel.returnPackage(idPackage: idPackage) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.package_name.text = data.package.package_name
                    self.package_weight.text = data.package.package_weight
                    self.package_recovery.text = data.package.package_recovery_city
                    self.destination_number.text =  String(describing: data.package.package_destination_number)
                    self.destination_street.text = data.package.package_destination_street
                    self.destination_zip.text = String(describing: data.package.package_destination_zip)
                    self.destination_city.text = data.package.package_destination_city
                    self.package_note.text = data.package.package_note
                    let deadlineArr = data.package.package_deadline.components(separatedBy: "T")
                    self.package_date_deadline.text = deadlineArr[0]
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unassignedPackages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let package = unassignedPackages[indexPath.row]
        cell.textLabel?.text = "Package Name: \(package.package_name)\nDelivery Address: \(package.package_destination_city)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let package = unassignedPackages[indexPath.row]
        // Traiter la sélection d'une cellule
        returnSpecialPackage(idPackage: String(describing:package.id) )
    }
}
