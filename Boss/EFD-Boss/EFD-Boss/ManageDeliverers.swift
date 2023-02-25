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
    
    func returnDeliverers(completion: @escaping (Result<DeliverersData, Error>) -> Void){
        let urlString = apiService.baseUrl+"deliverers"
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
                let deliverers = try JSONDecoder().decode(DeliverersData.self, from: data)
                completion(.success(deliverers))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func returnDeliverer(id: String, completion: @escaping (Result<DeliverersData, Error>) -> Void){
        let urlString = apiService.baseUrl+"deliverer/\(id)"
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
                let deliverer = try JSONDecoder().decode(DeliverersData.self, from: data)
                completion(.success(deliverer))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
