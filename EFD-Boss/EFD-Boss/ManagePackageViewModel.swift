//
//  ManagePackageViewModel.swift
//  EFD-Boss
//
//  Created by Elsa on 12/02/2023.
//

import Foundation

class ManagePackageViewModel: ObservableObject {
    
    func returnPackage(idPackage: String, completion: @escaping (Result<PackageData, Error>) -> Void) {
        let urlString = "http://192.168.1.27:2000/api/package?idPackage=\(idPackage)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let package = try JSONDecoder().decode(PackageData.self, from: data)
                completion(.success(package))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func unassignedPackage(completion: @escaping (Result<AllUnassignedPackage, Error>) -> Void) {
        let urlString = "http://192.168.1.27:2000/api/package_unassigned"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let package = try JSONDecoder().decode(AllUnassignedPackage.self, from: data)
                completion(.success(package))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func chooseEmployerPackage(idEmployer: String, idPackage: String, completion: @escaping (Result<UpdatePackage, Error>) -> Void) {
        let urlString = "http://192.168.1.27:2000/api/chooseEmployer?idEmployer=\(idEmployer)&idPackage=\(idPackage)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let package = try JSONDecoder().decode(UpdatePackage.self, from: data)
                completion(.success(package))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
