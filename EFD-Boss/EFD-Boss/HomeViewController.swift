//
//  HomeViewController.swift
//  EFD-Boss
//
//  Created by Elsa on 10/02/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var logoView: UIImageView!
    @IBOutlet var titlePage: UILabel!
    @IBOutlet var package_name: UILabel!
    @IBOutlet var package_deadline: UIView!
    @IBOutlet var package_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoView.image = UIImage(named: "Logo")
        titlePage.font = UIFont.boldSystemFont(ofSize: 30.0)
        titlePage.text = "Colis \n non assignés"
        titlePage.numberOfLines = 0
        package_name.font = UIFont.boldSystemFont(ofSize: 25.0)
        package_deadline.layer.borderWidth = 1
        package_deadline.layer.borderColor = UIColor.orange.cgColor
        // Do any additional setup after loading the view.
        self.package_table.dataSource = self
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
