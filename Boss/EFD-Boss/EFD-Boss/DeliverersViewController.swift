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
    let delivererViewModel = ManageDeliverer()
    var deliverers: [DelivererDetail] = [] // Data in deliverers.deliverers need to go here
    var locationManager: CLLocationManager?
    var zip : String = ""
    var city : String = ""
    let maxScore: Float = 5
    var currentRow: Int = 0
    var idDeliverer: Int = 0
    
    @IBOutlet weak var tableDeliverers: UITableView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var zipText: UITextField!
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var scoreProgress: UIProgressView!
    @IBOutlet weak var totalText: UITextField!
    /*
     PART ADDIND DELIVERER
     */
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var textName: UITextField!
    
    @IBOutlet weak var labelFirstname: UILabel!
    
    @IBOutlet weak var textFirstname: UITextField!
    
    @IBOutlet weak var textPassword: UITextField!
    
    @IBOutlet weak var labelPassword: UILabel!
    
    /*
     ----------------------------
     */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func editButton(_ sender: Any) {
        validerButton.isHidden = false
        
        // Disable all button with isUserInteractionEnabled
        nameText.isUserInteractionEnabled = true
        mailText.isUserInteractionEnabled = true
        phoneText.isUserInteractionEnabled = true
        zipText.isUserInteractionEnabled = true
        scoreText.isUserInteractionEnabled = true
        scoreProgress.isUserInteractionEnabled = true
        totalText.isUserInteractionEnabled = true
        self.mailText.becomeFirstResponder()
        self.phoneText.becomeFirstResponder()
        self.zipText.becomeFirstResponder()
    }
    @IBOutlet weak var validerButton: UIButton!
    
    @IBAction func addDeliverer(_ sender: Any) {
        validerButton.isHidden = false
        
        // Disable all button with isUserInteractionEnabled
        nameText.isHidden = true
        labelName.isHidden = false
        labelFirstname.isHidden = false // name
        labelPassword.isHidden = false
        textName.isHidden = false // firstname
        textPassword.isHidden = false
        textFirstname.isHidden = false
        labelName.isUserInteractionEnabled = true
        labelFirstname.isUserInteractionEnabled = true
        labelPassword.isUserInteractionEnabled = true
        textName.isUserInteractionEnabled = true
        textPassword.isUserInteractionEnabled = true
        textFirstname.isHidden = true
        mailText.isUserInteractionEnabled = true
        phoneText.isUserInteractionEnabled = true
        zipText.isUserInteractionEnabled = true
        scoreText.isUserInteractionEnabled = true
        scoreProgress.isUserInteractionEnabled = true
        totalText.isUserInteractionEnabled = true
        self.textName.becomeFirstResponder()
        self.textPassword.becomeFirstResponder()
        self.textFirstname.becomeFirstResponder()
        self.mailText.becomeFirstResponder()
        self.phoneText.becomeFirstResponder()
        self.zipText.becomeFirstResponder()
    }
    @IBAction func validerButtonAction(_ sender: Any) {
        if (textPassword.isHidden == false) {
            self.mailText.resignFirstResponder()
            self.phoneText.resignFirstResponder()
            self.zipText.resignFirstResponder()
            
            let deliverer = self.deliverers[currentRow]
            let geocoder = CLGeocoder()
            if ((self.zipText.text != nil) || (deliverer.location_zip != nil)) {
                geocoder.geocodeAddressString(String(((self.zipText.text ?? deliverer.location_zip)!))) { (placemarks, error) in
                    guard let placemark = placemarks?.first else {
                        return
                    }
                    let latitude = placemark.location?.coordinate.latitude
                    let longitude = placemark.location?.coordinate.longitude
                    let phoneValue: String = String(self.phoneText.text ?? String(deliverer.deliverer_phone))
                    self.delivererViewModel.updateDeliverer(id: deliverer.id_deliverer,
                                                       email: deliverer.deliverer_email,
                                                       password: deliverer.deliverer_password,
                                                       phone: phoneValue,
                                                       longitude: String(longitude ?? CLLocationDegrees(deliverer.location_longitude)),
                                                       latitude: String(latitude ?? CLLocationDegrees(deliverer.location_latitude))) { result in
                        switch result {
                        case .success(_):
                            print("ok")
                        case .failure(let error):
                            DispatchQueue.main.sync {
                                print("Network error : \(error)")
                            }
                        }
                    }
                }
            }
        } else if (textPassword.isHidden == false) {
            self.textName.resignFirstResponder()
            self.textPassword.resignFirstResponder()
            self.textFirstname.resignFirstResponder()
            self.mailText.resignFirstResponder()
            self.phoneText.resignFirstResponder()
            self.zipText.resignFirstResponder()
            
            //let deliverer = self.deliverers[currentRow]
            let geocoder = CLGeocoder()
            /*if ((self.zipText.text != nil)) {
                geocoder.geocodeAddressString(String(unsafeUninitializedCapacity: ((self.zipText.text))) { (placemarks, error) in
                    guard let placemark = placemarks.first else {
                        return
                    }
                    let latitude = placemark.location?.coordinate.latitude
                    let longitude = placemark.location?.coordinate.longitude
                    let phoneValue: String = String(self.phoneText.text)
                    self.delivererViewModel.addDeliverer(id: <#T##Int#>, email: <#T##String#>, password: <#T##String#>, phone: <#T##String#>, longitude: <#T##String#>, latitude: <#T##String#>, name: <#T##String#>, firstname: <#T##String#>, photo: <#T##String#>, evaluation: <#T##String#>, total: <#T##String#>, completion: <#T##(Result<DeliverersData, Error>) -> Void#>) { result in
                        switch result {
                        case .success(_):
                            print("ok")
                        case .failure(let error):
                            DispatchQueue.main.sync {
                                print("Network error : \(error)")
                            }
                        }
                    }
                }
            }*/
        }
    }
    
    
    @IBAction func previousButton(_ sender: Any) {
        if (currentRow >= 0 ) {
            if (self.deliverers.count > currentRow-1 && tableDeliverers.numberOfRows(inSection: 0) >= currentRow-1) {
                let deliverer = self.deliverers[currentRow-1]
                if ((deliverer.id_deliverer) != 0) {
                    currentRow-=1
                    // Update data
                    nameText.text = "\(deliverer.deliverer_firstname) \( deliverer.deliverer_name)"
                    mailText.text = "\(deliverer.deliverer_email)"
                    phoneText.text = "\(deliverer.deliverer_phone)"
                    zipText.text = "\(String(describing: deliverer.location_zip))"
                    totalText.text = "\(deliverer.deliverer_total) €"
                    scoreText.text = "\(deliverer.deliverer_evaluation) / \(maxScore)"
                    scoreProgress.progress = deliverer.deliverer_evaluation / maxScore
                } else { return }
            }
        } else {
            return
        }
    }
    @IBAction func nextButton(_ sender: Any) {
        if (tableDeliverers.numberOfRows(inSection: 0) >= currentRow+1 && currentRow+1 >= 0 ) {
            currentRow+=1
            if (self.deliverers.count > currentRow) {
                let deliverer = self.deliverers[currentRow]
                if ((deliverer.id_deliverer) != 0) {
                    // Update data
                    nameText.text = "\(deliverer.deliverer_firstname) \( deliverer.deliverer_name)"
                    mailText.text = "\(deliverer.deliverer_email)"
                    phoneText.text = "\(deliverer.deliverer_phone)"
                    zipText.text = "\(String(describing: deliverer.location_zip))"
                    totalText.text = "\(deliverer.deliverer_total) €"
                    scoreText.text = "\(deliverer.deliverer_evaluation) / \(maxScore)"
                    scoreProgress.progress = deliverer.deliverer_evaluation / maxScore
                } else { return }
            }
        } else {
            return
        }
    }
    @IBAction func deleteProfil(_ sender: Any) {
        let deliverer = self.deliverers[currentRow]
        delivererViewModel.deleteDeliverer(id: deliverer.id_deliverer ) { result in
            switch result {
            case .success(_):
                print("ok")
            case .failure(let error):
                DispatchQueue.main.sync {
                    print("Network error : \(error)")
                }
            }
        }
        
        
        deliverersViewModel.returnDeliverers() { result in
            switch result {
            case .success(let data):
                if data.status == 200 {
                    // Utilisez les données du packageData ici
                    self.deliverers = data.deliverers
                    DispatchQueue.main.sync {
                        self.tableDeliverers.delegate = self
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableDeliverers.allowsSelection = true
        self.tableDeliverers.dataSource = self
        // Disable all button with isUserInteractionEnabled
        nameText.isUserInteractionEnabled = false
        mailText.isUserInteractionEnabled = false
        phoneText.isUserInteractionEnabled = false
        zipText.isUserInteractionEnabled = false
        scoreText.isUserInteractionEnabled = false
        scoreProgress.isUserInteractionEnabled = false
        totalText.isUserInteractionEnabled = false

        validerButton.isHidden = true
        labelName.isHidden = true
        labelFirstname.isHidden = true
        labelPassword.isHidden = true
        textName.isHidden = true
        textPassword.isHidden = true
        textFirstname.isHidden = true
        // API request
        deliverersViewModel.returnDeliverers() { result in
            switch result {
            case .success(let data):
                if data.status == 200 {
                    // Utilisez les données du packageData ici
                    self.deliverers = data.deliverers
                    DispatchQueue.main.sync {
                        self.tableDeliverers.delegate = self
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

extension DeliverersViewController: UITableViewDataSource, CLLocationManagerDelegate, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliverers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var deliverer = deliverers[indexPath.row]
        // Convert latitude longitude to GPS address
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        center.latitude = Double(deliverer.location_latitude)
        center.longitude = Double(deliverer.location_longitude)
        let location: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            let pm = (placemarks!) as [CLPlacemark]
            self.zip = pm[0].postalCode!
            self.city = pm[0].locality!
            Logger.shared.log(.app, .info, "\(deliverer)")

            deliverer.location_zip = pm[0].postalCode!
            deliverer.location_city = pm[0].locality!
            if (error != nil) {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            //Set it in geocoder because it's a async request, if the text cell definition is in the tableview
            // it will be in the main thread so this will display nothing
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "\(deliverer.deliverer_firstname) \( deliverer.deliverer_name)\n \(self.zip) \(self.city)"
            // Update profil description with the last deliverer
            self.nameText.text = "\(deliverer.deliverer_firstname) \( deliverer.deliverer_name)"
            self.mailText.text = "\(deliverer.deliverer_email)"
            self.phoneText.text = "\(deliverer.deliverer_phone)"
            self.zipText.text = "\(deliverer.location_zip)"
            self.totalText.text = "\(deliverer.deliverer_total) €"
            self.scoreText.text = "\(deliverer.deliverer_evaluation) / \(self.maxScore)"
            self.scoreProgress.progress = deliverer.deliverer_evaluation / self.maxScore
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deliverer = self.deliverers[indexPath.row]
        nameText.text = "\(deliverer.deliverer_firstname) \( deliverer.deliverer_name)"
        mailText.text = "\(deliverer.deliverer_email)"
        phoneText.text = "\(deliverer.deliverer_phone)"
        zipText.text = "\(deliverer.location_zip)"
        print(deliverer.location_zip)
        totalText.text = "\(deliverer.deliverer_total) €"
        scoreText.text = "\(deliverer.deliverer_evaluation) / \(maxScore)"
        scoreProgress.progress = deliverer.deliverer_evaluation / maxScore

    }
    

}
