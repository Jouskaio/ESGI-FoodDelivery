//
//  Colis.swift
//  Deliverer
//
//  Created by Maaz TAGELDIN on 23/02/2023.
//

import Foundation
import UIKit

class Colis {
    var id: Int
    var package_name: String
    var package_weigt: Int
    var package_deadline : Date
    var package_not : String
    var package_destination_number : Int
    var package_destination_street : String
    var package_destination_city : String
    var package_destination_zip : Int
    var package_id_delivery : Int
    var package_id_sender : Int
    var package_recovery_city : String
    var package_id_employer : Int
    var package_photo : UIImage?
    
    init(id: Int,
         package_name: String,
         package_weigt: Int,
         package_deadline : Date,
         package_not : String,
         package_destination_number : Int,
         package_destination_street : String,
         package_destination_city : String,
         package_destination_zip : Int,
         package_id_delivery : Int,
         package_id_sender : Int,
         package_recovery_city : String,
         package_id_employer : Int,
         package_photo : UIImage?
    
    ) {
        self.id = id
        self.package_name = package_name
        self.package_name = package_name
        self.package_weigt = package_weigt
        self.package_deadline = package_deadline
        self.package_not = package_not
        self.package_destination_number = package_destination_number
        self.package_destination_street = package_destination_street
        self.package_destination_city = package_destination_city
        self.package_destination_zip = package_destination_zip
        self.package_id_delivery = package_id_delivery
        self.package_id_sender = package_id_sender
        self.package_recovery_city = package_recovery_city
        self.package_id_employer = package_id_employer
        self.package_photo = package_photo
        
    }
}

