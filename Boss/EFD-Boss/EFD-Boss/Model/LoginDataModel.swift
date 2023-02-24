//
//  LoginDataModel.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 23/02/2023.
//

import Foundation

class LoginData:Codable {
    var status: Int?
    var login: LoginDetails
    var error: String?
}

class LoginDetails:Codable, Identifiable  {
    var employer_email: String?
    var employer_password: String?
    
    enum CodingKeys: String, CodingKey {
        case employer_email
        case employer_password
    }
}
