//
//  DeliverersViewController.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 24/02/2023.
//

import UIKit
import NSLoggerSwift

class DeliverersViewController: UIViewController {
    let deliverersViewModel = ManageDeliverers()
    var delivererService: DeliverersService = DeliverersInMemoryService()
    var deliverers: [DeliverersData] = [] // Data in deliverers.deliverers need to go here
    
    @IBOutlet weak var tableDeliverers: UITableView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var zipText: UITextField!
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var scoreProgress: UIProgressView!
    @IBOutlet weak var totalText: UITextField!
    @IBAction func previousButton(_ sender: Any) {
    }
    @IBAction func nextButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableDeliverers.dataSource = self
        // TODO: Ajouter la requête API ici
        deliverersViewModel.returnDeliverers() { deliverer in
            if deliverer.status == 200 {
                // Utilisez les données du packageData ici
                Logger.shared.log(.routing, .error, "Error: \(deliverer.deliverers[0].deliverer_firstname )")
            } else {
                Logger.shared.log(.routing, .error, "Error: \(deliverer.error ?? "Unknown error")")
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DeliverersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deliverers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deliverer = self.deliverers[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(String(describing: deliverer.status))"
        return cell
    }
}
