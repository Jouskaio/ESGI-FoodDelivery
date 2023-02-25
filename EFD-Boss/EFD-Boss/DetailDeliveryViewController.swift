//
//  DetailDeliveryViewController.swift
//  EFD-Boss
//
//  Created by Elsa on 24/02/2023.
//

import UIKit

class DetailDeliveryViewController: UIViewController {
    
    @IBOutlet var package_table: UITableView!
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var package_photo: UIImageView!
    @IBOutlet var titlePage: UILabel!
    @IBOutlet var package_name: UILabel!
    @IBOutlet var package_weight: UILabel!
    @IBOutlet var package_recovery_city: UILabel!
    @IBOutlet var destination_number: UILabel!
    @IBOutlet var destination_street: UILabel!
    @IBOutlet var destination_zip: UILabel!
    @IBOutlet var destination_city: UILabel!
    @IBOutlet var package_date: UILabel!
    @IBOutlet var package_employer: UILabel!
    @IBOutlet var delivery_id: UILabel!
    @IBOutlet var package_trackingID: UILabel!
    
    let packageViewModel = ManagePackageViewModel()
    var assignedPackages: [UnassignedPackage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.image = UIImage(named: "Logo")
        titlePage.font = UIFont.boldSystemFont(ofSize: 30.0)
        titlePage.text = "Liste des colis assignés"
        titlePage.numberOfLines = 0
        
         self.package_table.dataSource = self
         self.package_table.delegate = self
         self.package_table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        assignedPackage()
    }
    
    private func assignedPackage() {
        packageViewModel.assignedPackage() { result in
            switch result {
            case .success(let data):
                self.assignedPackages = data.package
                DispatchQueue.main.async {
                    self.package_table.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func returnPackageAssignated(idPackage: String) {
        packageViewModel.returnPackageAssignated(idPackage: idPackage){ result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.package_name.text = data.package.package_name
                    self.package_weight.text = data.package.package_weight
                    self.package_recovery_city.text = data.package.package_recovery_city
                    self.destination_number.text =  String(describing: data.package.package_destination_number)
                    self.destination_street.text = data.package.package_destination_street
                    self.destination_zip.text = String(describing: data.package.package_destination_zip)
                    self.destination_city.text = data.package.package_destination_city
                    let deadlineArr = data.package.package_deadline.components(separatedBy: "T")
                    self.package_date.text = deadlineArr[0]
                    self.package_employer.text = data.employer.employer_firstname + " " + data.employer.employer_name
                    self.delivery_id.text = "Livraison n°" + String(describing:data.package.package_id_delivery)
                    if(data.package.package_trackingid != nil) {
                        self.package_trackingID.text = "TrackingID: " + String(data.package.package_trackingid ?? 0)
                    } else {
                        self.package_trackingID.text = "TrackingID:"
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}

extension DetailDeliveryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignedPackages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
         let package = assignedPackages[indexPath.row]
         cell.textLabel?.text = "Produit: \(package.package_name)\nVille de livraison: \(package.package_destination_city)"
         cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let package = assignedPackages[indexPath.row]
        returnPackageAssignated(idPackage: String(describing:package.id) )
    }
}

