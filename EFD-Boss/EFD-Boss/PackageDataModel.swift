//
//  PackageDataModel.swift
//  EFD-Boss
//
//  Created by Elsa on 12/02/2023.
//

import Foundation

struct PackageData:Codable{
    var status: Int
    var package: Package
    var error: String?
}

struct Package: Codable {
    let id: Int
    let package_name: String
    let package_weight: String
    let package_deadline: String
    let package_note: String?
    let package_destination_number: Int
    let package_destination_street: String
    let package_destination_city: String
    let package_destination_zip: Int
    let package_recovery_city: String?
}

struct AllUnassignedPackage:Codable{
    var status: Int
    var package: [UnassignedPackage]
    var error: String?
}

struct UnassignedPackage: Codable {
    let id: Int
    let package_name: String
    let package_destination_city: String
}

