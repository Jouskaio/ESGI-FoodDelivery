//
//  DelivererDataModel.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 24/02/2023.
//

import Foundation
import NSLoggerSwift

struct DeliverersData: Codable {
    var status: Int?
    var error: String?
    var deliverers: [Deliverer]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Logger.shared.log(.routing, .debug, "\(container.allKeys)")
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
        self.deliverers = try container.decode([Deliverer].self, forKey: .deliverers)
    }
}


struct SingleDelivererData: Codable {
    var status: Int?
    var error: String?
    var id_deliverer: Int
    var deliverer_firstname: String
    var deliverer_name: String
    var deliverer_email: String
    var deliverer_password: String
    var deliverer_phone: Int
    var deliverer_photo: String?
    var location_latitude: Float
    var location_longitude: Int?
    var deliverer_total: Float
    
    enum CodingKeys: String, CodingKey {
        case status
        case error
        case id_deliverer
        case deliverer_firstname
        case deliverer_name
        case deliverer_email
        case deliverer_password
        case deliverer_phone
        case deliverer_photo
        case location_latitude
        case location_longitude
        case deliverer_total
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
        self.id_deliverer = try container.decode(Int.self, forKey: .id_deliverer)
        self.deliverer_firstname = try container.decode(String.self, forKey: .deliverer_firstname)
        self.deliverer_name = try container.decode(String.self, forKey: .deliverer_name)
        self.deliverer_email = try container.decode(String.self, forKey: .deliverer_email)
        self.deliverer_password = try container.decode(String.self, forKey: .deliverer_password)
        self.deliverer_phone = try container.decode(Int.self, forKey: .deliverer_phone)
        self.deliverer_photo = try container.decodeIfPresent(String.self, forKey: .deliverer_photo)
        self.location_latitude = try container.decode(Float.self, forKey: .location_latitude)
        self.location_longitude = try container.decodeIfPresent(Int.self, forKey: .location_longitude)
        self.deliverer_total = try container.decode(Float.self, forKey: .deliverer_total)
    }
}

struct Deliverer: Codable {
    var id_deliverer: Int = 1
    var deliverer_firstname: String = "Louis"
    var deliverer_name: String = "Finès"
    var deliverer_email: String = "mail.funès@prod.fr"
    var deliverer_password: String = "test"
    var deliverer_phone: Int = 0666666666
    var deliverer_photo: String? = ""
    var location_latitude: Float = 0
    var location_longitude: Float = 0
    var deliverer_total: Float = 0
    
    enum CodingKeys: String, CodingKey {
        case id_deliverer
        case deliverer_firstname
        case deliverer_name
        case deliverer_email
        case deliverer_password
        case deliverer_phone
        case deliverer_photo
        case location_latitude
        case location_longitude
        case deliverer_total
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //Logger.shared.log(.routing, .debug, "\(container.allKeys)")
        self.id_deliverer = try container.decode(Int.self, forKey: .id_deliverer)
        self.deliverer_firstname = try container.decode(String.self, forKey: .deliverer_firstname)
        self.deliverer_name = try container.decode(String.self, forKey: .deliverer_name)
        self.deliverer_email = try container.decode(String.self, forKey: .deliverer_email)
        self.deliverer_password = try container.decode(String.self, forKey: .deliverer_password)
        self.deliverer_phone = try container.decode(Int.self, forKey: .deliverer_phone)
        self.location_latitude = try container.decode(Float.self, forKey: .location_latitude)
        self.location_longitude = try container.decode(Float.self, forKey: .location_longitude)
        self.deliverer_total = try container.decode(Float.self, forKey: .deliverer_total)
        self.deliverer_photo = try container.decode(String.self, forKey: .deliverer_total)
    }
}
