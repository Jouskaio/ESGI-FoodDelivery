//
//  ManageEmployerViewModel.swift
//  Deliverer
//
//  Created by Maaz TAGELDIN on 25/02/2023.
//

import Foundation

class ManageEmployerViewModel: ObservableObject {
    
    func createEmployer(employer_firstname : String, employer_name: String,  employer_email : String, employer_phone : String, employer_password : String,  completion: @escaping (Result<EmployerMessage, Error>) -> Void) {
    
        let urlString = "http://192.168.1.47:2000/api/createEmployer?employer_firstname=\(employer_firstname)&employer_name=\(employer_name)&employer_email=\(employer_email)&employer_phone=\(employer_phone)&employer_password=\(employer_password)"
        
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
                let employerMessage = try JSONDecoder().decode(EmployerMessage.self, from: data)
                completion(.success(employerMessage))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    // Log in
    
    func connexion (employer_email : String,employer_password : String,  completion: @escaping (Result<EmployerMessage, Error>) -> Void) {
    
        let urlString = "http://192.168.1.47:2000/api/login?email=\(employer_email)&password=\(employer_password)"
        
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
                let employerMessage = try JSONDecoder().decode(EmployerMessage.self, from: data)
                completion(.success(employerMessage))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
