//
//  PackageDetailsViewController.swift
//  Deliverer
//
//  Created by Maaz TAGELDIN on 25/02/2023.
//

import UIKit

    
class PackageDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableView: UITableView!
    
    
    let sections = ["Section 1", "Section 2"]
    let items = [["Package Weight", "Item 2", "Item 3", "Item 4"], ["Package Name", "Item 2", "Item 3", "Item 4"]]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.textLabel?.text = "Package Weight"
        } else if indexPath.section == 1 && indexPath.row == 0 {
            cell.textLabel?.text = "Package Name"
        } else {
            cell.textLabel?.text = items[indexPath.section][indexPath.row]
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
