//
//  AssignedPackageViewController.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 27/02/2023.
//

import UIKit

class AssignedPackageViewController: UIViewController {

    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var package_deadline: UILabel!
    @IBOutlet weak var package_table: UITableView!
    @IBOutlet weak var package_employer: UIPickerView!
    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var package_name: UILabel!
    @IBOutlet weak var package_weight: UILabel!
    @IBOutlet weak var package_recovery: UILabel!
    @IBOutlet weak var destination_number: UILabel!
    @IBOutlet weak var destination_street: UILabel!
    @IBOutlet weak var destination_zip: UILabel!
    @IBOutlet weak var destination_city: UILabel!
    @IBOutlet weak var package_note: UILabel!
    @IBOutlet weak var package_date_deadline: UILabel!
    
    
    var id_package: Int = 0
    
    let packageViewModel = ManagePackageViewModel()
    var unassignedPackages: [UnassignedPackage] = []
    
    let employerViewModel = ManageEmployerViewModel()
    var employers: [Employer] = []
    
    
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
        
        package_employer.dataSource = self
        package_employer.delegate = self
        
        getUnassignedPackage()
        
        employerViewModel.allEmployers { result in
            switch result {
            case .success(let data):
                self.employers = data.employer
                DispatchQueue.main.async {
                    self.package_employer.reloadAllComponents()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func returnSpecialPackage(idPackage: String) {
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
                    self.id_package = data.package.id
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func getUnassignedPackage() {
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
    
}

extension AssignedPackageViewController: UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unassignedPackages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let package = unassignedPackages[indexPath.row]
        cell.textLabel?.text = "Produit: \(package.package_name)\nVille de livraison: \(package.package_destination_city)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let package = unassignedPackages[indexPath.row]
        returnSpecialPackage(idPackage: String(describing:package.id) )
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return employers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let employer = employers[row]
        return "\(employer.employer_name) \(employer.employer_firstname)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedEmployer = employers[row]
        packageViewModel.chooseEmployerPackage(idEmployer: String(describing:selectedEmployer.id), idPackage: String(describing:self.id_package)) { result in
            switch result {
            case .success(_):
                self.getUnassignedPackage()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
