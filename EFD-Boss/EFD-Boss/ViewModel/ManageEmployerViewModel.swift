//
//  ManageEmployerViewModel.swift
//  EFD-Boss
//
//  Created by Elsa on 19/02/2023.
//

import Foundation

class ManageEmployerViewModel: ObservableObject {
    
    let urlApi = ApiService()
    
    func allEmployers(completion: @escaping (Result<AllEmployers, Error>) -> Void) {
        let urlString = urlApi.baseUrl + "/employers"
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
                let package = try JSONDecoder().decode(AllEmployers.self, from: data)
                completion(.success(package))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
