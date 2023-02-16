//
//  PackageDataModel.swift
//  EFD-Boss
//
//  Created by Elsa on 12/02/2023.
//

import Foundation

class PackageData:Codable, Identifiable {
    var status: Int
    var package: PackageDetails
    var error: String?
}

class PackageDetails:Codable {
    var id_package: Int
    var package_name: String
    var package_weight: String
    var package_deadline: Date
    var package_note: String?
    var package_destination_number: Int
    var package_destination_street: String
    var package_destination_city: String
    var package_destination_zip: Int
    var package_recovery_city: String?
}
