//
//  Tournee.swift
//  Deliverer
//
//  Created by Maaz TAGELDIN on 23/02/2023.
//

import Foundation

class Tournee {
    var id: Int
    var delivery_date: Date
    var delivery_location: String
    var id_employer : Int
    var colis: [Colis]
    
    init(
        id: Int,
         delivery_date: Date,
         delivery_location: String,
         id_employer : Int,
         colis: [Colis]
    ) {
        self.id = id
        self.delivery_date = delivery_date
        self.delivery_location = delivery_location
        self.id_employer = id_employer
        self.colis = colis
    }
}

