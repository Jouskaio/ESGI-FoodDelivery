//
//  Employer.swift
//  Deliverer
//
//  Created by Maaz TAGELDIN on 25/02/2023.
//

import Foundation

struct EmployerMessage:Codable{
    var status: Int
    var employer: String
    var error: String?
}

struct LoginEmployer: Codable {
    var status: Int
    var employer: Employer
    var error: String?
}

struct Employer: Codable {
    var id: Int
    var employer_email: String
    var employer_password: String
}
