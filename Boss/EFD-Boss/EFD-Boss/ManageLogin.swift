//
//  ManageLogin.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 23/02/2023.
//

import Foundation

class ManageLogin: ObservableObject {
    
    let apiService = ApiService()
    
    func returnLogin(email: String, password: String, completion: @escaping (Result<LoginData, Error>) -> Void){
        let urlString = apiService.baseUrl+"loginBoss?email=\(email)&password=\(password)"
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
                let login = try JSONDecoder().decode(LoginData.self, from: data)
                completion(.success(login))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
