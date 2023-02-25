//
//  ManageDeliverers.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 25/02/2023.
//

import Foundation

import Foundation
import NSLoggerSwift

class ManageDeliverers: ObservableObject {
    
    let apiService = ApiService()
    
    func returnDeliverers(completion: @escaping (DeliverersData) -> Void){
        var component = URLComponents()
        component.path = "deliverers"
        let completeStringUrl = apiService.baseUrl + (component.string ?? "")
        guard let url = URL(string: completeStringUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url){data, res, error in
            if(error != nil) {
                print(error?.localizedDescription as Any)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let launch = try decoder.decode(DeliverersData.self, from: data!)
                Logger.shared.log(.routing, .noise, "\(launch)")
                completion(launch)
            } catch {
                print(error)
            }
        }.resume()
    }
}
