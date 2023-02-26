//
//  PackageTableViewController.swift
//  Deliverer
//
//  Created by Maaz TAGELDIN on 25/02/2023.
//

import UIKit

class PackageTableViewController: UITableViewController {
    
    @IBOutlet var package_table: UITableView!
    var idEmployer: Int = 0
    
    let packageViewModel = ManagePackageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(idEmployer)
        
        packageViewModel.returnAllPackageEmployer(idEmployer: "1") { result in
            switch result {
            case .success(let data):
                print("Success")
                print(data)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}

