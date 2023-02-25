//
//  LoginDataModel.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 23/02/2023.
//

import Foundation
import NSLoggerSwift

struct LoginData: Decodable {
    var status: Int?
    var employer_email: String
    var employer_password: String
    var error: String?
    
}

/*struct LoginDetails: Decodable  {
    var employer_email: String?
    var employer_password: String?
    
    enum CodingKeys: String, CodingKey {
        case employer_email
        case employer_password
    }
    /*TODO: This class is not understood by the JSON.decoder() idk why, it returns me nil each time but no errors or warning... **/
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.employer_email = try container.decodeIfPresent(String.self, forKey: .employer_email) ?? "jonesdup@hotmail.fr"
        self.employer_password = try container.decodeIfPresent(String.self, forKey: .employer_password) ?? "TestPassword"
    }
}*/
