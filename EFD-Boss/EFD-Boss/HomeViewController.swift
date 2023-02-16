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
    var response: [PackageDetails] = [];

    
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
        /*
        packageViewModel.returnPackage(idPackage: 1) { data in
            print(data)
            self.response = data.package
        }*/
        
        packageViewModel.returnPackage(idPackage: 1) { packageData in
            if packageData.status == 200 {
                   print(packageData.package)
                   // Utilisez les données du packageData ici
               } else {
                   print("Error: \(packageData.error ?? "Unknown error")")
               }
        }
        
        print("croute")
        /*
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        for data in self.response {
            print("chou")
            package_name.text = data.package_name
            package_weight.text = data.package_weight
            package_recovery.text = data.package_recovery_city
            destination_number.text = String(describing: data.package_destination_number)
            destination_street.text = data.package_destination_street
            destination_zip.text = String(describing: data.package_destination_zip)
            destination_city.text = data.package_destination_city
            package_note.text = data.package_note
            package_date_deadline.text = dateFormatter.string(from: data.package_deadline)
        }
         */
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Ligne numéro \(indexPath.row)" // indexPath.row = le numéro de la ligne
        return cell
    }
}
