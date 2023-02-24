//
//  ManageLogin.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 23/02/2023.
//

import Foundation
import NSLoggerSwift


class ManageLogin: ObservableObject {
    
    let apiService = ApiService()
    
    func returnLogin(email: String, password: String, completion: @escaping (LoginData) -> Void){
        var component = URLComponents()
        component.path = "login"
        component.queryItems = [
            URLQueryItem(name: "email", value: "\(email)"),
            URLQueryItem(name: "password", value: "\(password)")
        ]
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
                let launch = try decoder.decode(LoginData.self, from: data!)
                Logger.shared.log(.routing, .info, "\(String(describing: launch.login))")
                completion(launch)
            } catch {
                print(error)
            }
        }.resume()
    }
}
