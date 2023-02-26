//
//  ManagePackageViewModel.swift
//  Deliverer
//
//  Created by Elsa on 26/02/2023.
//

import Foundation

class ManagePackageViewModel: ObservableObject {
    
    let urlApi = ApiService()
    
    func returnAllPackageEmployer(idEmployer: String, completion: @escaping (Result<AllPackage, Error>) -> Void) {
            let urlString = urlApi.baseUrl + "/packageSpecialEmployer?idEmployer=\(idEmployer)"
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
                    let package = try JSONDecoder().decode(AllPackage.self, from: data)
                    completion(.success(package))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    
}
