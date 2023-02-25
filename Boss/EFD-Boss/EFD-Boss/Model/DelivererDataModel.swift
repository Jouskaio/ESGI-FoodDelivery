//
//  DelivererDataModel.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 24/02/2023.
//

import Foundation
import NSLoggerSwift

struct DeliverersData: Codable {
    var status: Int?
    var error: String?
    var deliverers: [DelivererDetail]
}

struct DelivererDetail: Codable {
    var id_deliverer: Int
    var deliverer_firstname: String
    var deliverer_name: String
    var deliverer_email: String
    var deliverer_password: String
    var deliverer_phone: Int
    var deliverer_photo: String?
    var location_latitude: Float
    var location_longitude: Float
    var deliverer_total: Float
}
