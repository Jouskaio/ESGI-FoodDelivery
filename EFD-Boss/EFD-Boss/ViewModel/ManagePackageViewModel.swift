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
    
    func returnPackageAssignated(idPackage: String, completion: @escaping (Result<AssignatedPackageData, Error>) -> Void) {
        let urlString = "http://192.168.1.27:2000/api/specialPackage?idPackage=\(idPackage)"
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
                let package = try JSONDecoder().decode(AssignatedPackageData.self, from: data)
                completion(.success(package))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func returnPackageEmployer(idEmployer: String, completion: @escaping (Result<AllUnassignedPackage, Error>) -> Void) {
        let urlString = "http://192.168.1.27:2000/api/packageEmployer?idEmployer=\(idEmployer)"
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
    
    func returnPackageDelivery(idDelivery: String, completion: @escaping (Result<AllDeliveryPackage, Error>) -> Void) {
        let urlString = "http://192.168.1.27:2000/api/packageDelivery?idDelivery=\(idDelivery)"
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
                let package = try JSONDecoder().decode(AllDeliveryPackage.self, from: data)
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
    
    func assignedPackage(completion: @escaping (Result<AllUnassignedPackage, Error>) -> Void) {
        let urlString = "http://192.168.1.27:2000/api/package_assigned"
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
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                let updatePackage = try JSONDecoder().decode(UpdatePackage.self, from: data)
                completion(.success(updatePackage))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func chooseDeliveryPackage(idDelivery: String, idPackage: String, completion: @escaping (Result<UpdatePackage, Error>) -> Void) {
        let urlString = "http://192.168.1.27:2000/api/chooseDelivery?idDelivery=\(idDelivery)&idPackage=\(idPackage)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                let updatePackage = try JSONDecoder().decode(UpdatePackage.self, from: data)
                completion(.success(updatePackage))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
