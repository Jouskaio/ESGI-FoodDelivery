//
//  LoginDataModel.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 23/02/2023.
//

import Foundation
import NSLoggerSwift

struct LoginData: Codable {
    var status: Int?
    var employer: LoginDetail
    var error: String?
}

struct LoginDetail: Codable {
    var employer_email: String
    var employer_password: String
    var id: Int
}
