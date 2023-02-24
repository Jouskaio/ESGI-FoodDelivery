//
//  DeliveryDataModel.swift
//  EFD-Boss
//
//  Created by Elsa on 22/02/2023.
//

import Foundation

struct Delivery: Codable {
    var status: Int
    var delivery: Int
    var error: String?
}

struct DeliveryMessage: Codable {
    var status: Int
    var delivery: String
    var error: String?
}

struct AllDelivery:Codable{
    var status: Int
    var delivery: [SpecialDelivery]
    var error: String?
}

struct SpecialDelivery: Codable {
    let id: Int
    let delivery_date: String
    let delivery_location: String?
}
