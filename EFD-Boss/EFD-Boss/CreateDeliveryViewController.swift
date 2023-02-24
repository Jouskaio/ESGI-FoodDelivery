//
//  CreateDeliveryViewController.swift
//  EFD-Boss
//
//  Created by Elsa on 21/02/2023.
//

import UIKit

class CreateDeliveryViewController: UIViewController {
    var employer_id: String = ""
    var delivery_id: String = ""
    var packages: [UnassignedPackage] = []
    
    @IBOutlet var title_page: UILabel!
    @IBOutlet var packageTable: UITableView!
    @IBAction func back_button(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title_page.text = "Si vous touchez un colis, cela l'ajoute à la tournée"
        title_page.font = UIFont.systemFont(ofSize: 34)
        
        self.packageTable.dataSource = self
        self.packageTable.delegate = self
        self.packageTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        returnPackageEmployer(idEmployer: String(describing:employer_id))
    }
    
    private func returnPackageEmployer(idEmployer: String) {
        let packageViewModel = ManagePackageViewModel()
        packageViewModel.returnPackageEmployer(idEmployer: idEmployer){ result in
            switch result {
            case .success(let data):
                self.packages = data.package
                DispatchQueue.main.async {
                    self.packageTable.reloadData()
                }
            case .failure(let error):
                self.packages = []
                DispatchQueue.main.async {
                    self.packageTable.reloadData()
                }
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func chooseDeliveryPackage(idDelivery: String, idPackage: String) {
        let packageViewModel = ManagePackageViewModel()
        packageViewModel.chooseDeliveryPackage(idDelivery: idDelivery, idPackage: idPackage) { result in
            switch result {
            case .success(_):
                self.returnPackageEmployer(idEmployer: self.employer_id)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

extension CreateDeliveryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let package = packages[indexPath.row]
        cell.textLabel?.text = "\(package.package_name)\nVille de livraison: \(package.package_destination_city)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let package = packages[indexPath.row]
        chooseDeliveryPackage(idDelivery: delivery_id, idPackage: String(describing:package.id))
    }
}
