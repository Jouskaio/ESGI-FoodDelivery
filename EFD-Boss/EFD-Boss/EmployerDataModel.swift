//
//  EmployerDataModel.swift
//  EFD-Boss
//
//  Created by Elsa on 19/02/2023.
//

import Foundation

struct AllEmployers:Codable{
    var status: Int
    var employer: [Employer]
    var error: String?
}

struct Employer: Codable {
    let id: Int
    let employer_name: String
    let employer_firstname: String
}
