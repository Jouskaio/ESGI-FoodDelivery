//
//  TourneeListViewController.swift
//  Deliverer
//
//  Created by Maaz TAGELDIN on 23/02/2023.
//
/*
import UIKit

class TourneeListViewController: UITableViewController {
    var tournees: [Tournee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTournees()
    }
    
    func fetchTournees() {
        // Récupérer la liste des tournées depuis une API
        // Exemple de réponse JSON :
        // [
        //   {
        //     "id": 1,
        //     "destination": "Paris",
        //     "date": "2023-02-10T10:00:00Z",
        //     "colis": [
        //       {
        //         "id": 1,
        //         "trackingID": "ABC123"
        //       },
        //       {
        //         "id": 2,
        //         "trackingID": "XYZ789"
        //       }
        //     ]
        //   },
        //   ...
        // ]
        
        // Ici, on crée des tournées et des colis de manière statique pour l'exemple
        let colis1 = Colis(id: 1, trackingID: "ABC123")
        let colis2 = Colis(id: 2, trackingID: "XYZ789")
        let tournee1 = Tournee(id: 1, destination: "Paris", date: Date(), colis: [colis1, colis2])
        let tournee2 = Tournee(id: 2, destination: "Lyon", date: Date(), colis: [colis1])
        tournees = [tournee1, tournee2]
        
        // Actualiser la table view
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
*/
