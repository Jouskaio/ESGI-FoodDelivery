//
//  Package.swift
//  Deliverer
//
//  Created by Elsa on 26/02/2023.
//

import Foundation

struct AllPackage:Codable{
    var status: Int
    var package: [Package]
    var error: String?
}

struct Package: Codable {
    let id: Int
    let package_name: String
    let package_destination_city: String
}
