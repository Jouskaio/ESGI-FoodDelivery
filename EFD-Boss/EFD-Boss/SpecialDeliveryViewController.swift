//
//  SpecialDeliveryViewController.swift
//  EFD-Boss
//
//  Created by Elsa on 22/02/2023.
//

import UIKit

class SpecialDeliveryViewController: UIViewController {
    var employer_id: String = ""
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var titlePage: UILabel!
    @IBOutlet var id_delivery: UILabel!
    
    @IBOutlet var delivery_table: UITableView!
    @IBOutlet var package_table: UITableView!
    @IBAction func back_button(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var delivery: [SpecialDelivery] = []
    var packages: [DeliveryPackage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.image = UIImage(named: "Logo")
        titlePage.font = UIFont.boldSystemFont(ofSize: 30.0)
        titlePage.text = "Liste des tournées"
        titlePage.numberOfLines = 0
        
        self.delivery_table.dataSource = self
        self.delivery_table.delegate = self
        self.delivery_table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.package_table.dataSource = self
        self.package_table.delegate = self
        self.package_table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        returnDeliveryEmployer(idEmployer: employer_id)
    }
    
    private func returnDeliveryEmployer(idEmployer: String) {
        let deliveryViewModel = ManageDeliveryViewModel()
        deliveryViewModel.returnDeliveryEmployer(idEmployer: idEmployer) { result in
            switch result {
            case .success(let data):
                self.delivery = data.delivery
                DispatchQueue.main.async {
                    self.delivery_table.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func returnPackageDelivery(idDelivery: String) {
        let packageViewModel = ManagePackageViewModel()
        packageViewModel.returnPackageDelivery(idDelivery: idDelivery) { result in
            switch result {
            case .success(let data):
                self.packages = data.package
                DispatchQueue.main.async {
                    self.package_table.reloadData()
                }
            case .failure(let error):
                self.packages = [] // réinitialiser le tableau à un tableau vide
                DispatchQueue.main.async {
                    self.package_table.reloadData()
                }
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}

extension SpecialDeliveryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == delivery_table {
            return delivery.count
        } else {
            return packages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == delivery_table {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let specialDelivery = delivery[indexPath.row]
            let dateArr = specialDelivery.delivery_date.components(separatedBy: "T")
            cell.textLabel?.text = "Livraison \(specialDelivery.id)      Date de livraison: \(dateArr[0]) \nVille: \(specialDelivery.delivery_location ?? "")"
            cell.textLabel?.numberOfLines = 0
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let package = packages[indexPath.row]
            cell.textLabel?.text = "\(package.package_name)      Ville de livraison: \(package.package_destination_city) \nVille de récupération: \(package.package_recovery_city)"
            cell.textLabel?.numberOfLines = 0
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == delivery_table {
            let specialDelivery = delivery[indexPath.row]
            id_delivery.text = "Livraison " + String(describing:specialDelivery.id)
            returnPackageDelivery(idDelivery: String(describing:specialDelivery.id) )
        } else {
            // Traiter la sélection d'une cellule
            let package = packages[indexPath.row]
            print(package)
        }
    }
}
