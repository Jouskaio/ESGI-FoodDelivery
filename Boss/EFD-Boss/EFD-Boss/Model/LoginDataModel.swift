//
//  LoginDataModel.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 23/02/2023.
//

import Foundation

struct LoginData: Codable {
    var status: Int
    var employer: LoginDetail
    var error: String?
}

struct LoginDetail: Codable {
    var id: Int
    var employer_email: String
    var employer_password: String
}
