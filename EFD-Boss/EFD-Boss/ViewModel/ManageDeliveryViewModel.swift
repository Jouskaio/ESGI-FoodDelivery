//
//  ManageDeliveryViewModel.swift
//  EFD-Boss
//
//  Created by Elsa on 22/02/2023.
//

import Foundation

class ManageDeliveryViewModel: ObservableObject {
    
    func createDelivery(idEmployer: String, completion: @escaping (Result<Delivery, Error>) -> Void) {
        let urlString = "http://192.168.1.27:2000/api/createDelivery?idEmployer=\(idEmployer)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
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
                let delivery = try JSONDecoder().decode(Delivery.self, from: data)
                completion(.success(delivery))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func returnDeliveryEmployer(idEmployer: String, completion: @escaping (Result<AllDelivery, Error>) -> Void) {
        let urlString = "http://192.168.1.27:2000/api/employerDelivery?idEmployer=\(idEmployer)"
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
                let delivery = try JSONDecoder().decode(AllDelivery.self, from: data)
                completion(.success(delivery))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}