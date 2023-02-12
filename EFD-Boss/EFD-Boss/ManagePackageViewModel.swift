//
//  ManagePackageViewModel.swift
//  EFD-Boss
//
//  Created by Elsa on 12/02/2023.
//

import Foundation

class ManagePackageViewModel: ObservableObject {
    
    let apiService = ApiService()
    
    func returnPackage(idPackage: Int,completion: @escaping (PackageData) -> Void){
        let apiService = ApiService()
        
        var component = URLComponents()
        component.path = "package"
        component.queryItems = [
            URLQueryItem(name: "idPackage", value: "\(idPackage)")
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
                let launch = try decoder.decode(PackageData.self, from: data!)
                completion(launch)
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
