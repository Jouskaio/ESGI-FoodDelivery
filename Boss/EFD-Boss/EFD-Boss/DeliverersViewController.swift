//
//  DeliverersViewController.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 24/02/2023.
//

import UIKit
import NSLoggerSwift
import CoreLocation

class DeliverersViewController: UIViewController {
    let deliverersViewModel = ManageDeliverers()
    var deliverers: [DelivererDetail] = [] // Data in deliverers.deliverers need to go here
    var locationManager: CLLocationManager?
    var zip: String = ""
    var city: String = ""
    
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
        deliverersViewModel.returnDeliverers() { result in
            switch result {
            case .success(let data):
                if data.status == 200 {
                    // Utilisez les données du packageData ici
                    data.deliverers.forEach {
                        self.deliverers.append($0)
                    }
                    DispatchQueue.main.sync {
                        self.deliverers = self.deliverers
                        self.tableDeliverers.reloadData()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.sync {
                    print("Network error : \(error)")
                }
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

extension DeliverersViewController: UITableViewDataSource, CLLocationManagerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deliverers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deliverer = self.deliverers[indexPath.row]
        Logger.shared.log(.app, .debug, "\(deliverer)")
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        // Convert latitude longitude to GPS address
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        center.latitude = Double(deliverer.location_latitude)
        center.longitude = Double(deliverer.location_longitude)
        let location: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            let pm = placemarks! as [CLPlacemark]
            self.zip = pm[0].postalCode ?? ""
            self.city = pm[0].locality ?? ""
            if (error != nil) {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            //Set it in geocoder because it's a async request, if the text cell definition is in the tableview
            // it will be in the main thread so this will display nothing
            cell.textLabel?.text = "\(deliverer.deliverer_firstname) \( deliverer.deliverer_name)\n \(self.zip) \(self.city)"
            cell.textLabel?.numberOfLines = 0
            //self.numTextField.text = placemark.subThoroughfare
            //self.streetTextField.text = placemark.thoroughfare
            //self.cityTextField.text = placemark.locality
            //self.zipTextField.text = placemark.postalCode
            //self.countryTextField.text = placemark.country
        }
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Logger.shared.log(.app, .info, "section: \(indexPath.section)")
        Logger.shared.log(.app, .info, "section: \(indexPath.row)")
    }*/

}
