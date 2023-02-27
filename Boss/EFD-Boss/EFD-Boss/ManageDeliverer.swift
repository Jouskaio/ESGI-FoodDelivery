//
//  ManageDeliverer.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 26/02/2023.
//

import Foundation

import Foundation

class ManageDeliverer: ObservableObject {
    
    let apiService = ApiService()
    
    func deleteDeliverer(id: Int, completion: @escaping (Result<DeliverersData, Error>) -> Void){
        // Création de la demande DELETE
        let urlString = apiService.baseUrl+"deliverer/\(id)"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // Envoi de la demande à l'API
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                // Traitement de la réponse de l'API
                if let error = error {
                    print("Error : \(error.localizedDescription)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                    print("Statut de réponse invalide")
                    return
                }
                print("Requête DELETE réussie")
            }
            task.resume()
        }
    }
    
    
    func updateDeliverer(id: Int, email: String, password: String, phone: String, longitude: String, latitude: String,
                         completion: @escaping (Result<DeliverersData, Error>) -> Void){
        // Création de la demande update
        let urlString = apiService.baseUrl+"deliverer/\(id)?email=\(email)&password=\(password)&phone=\(phone)&longitude=\(longitude)&latitude=\(latitude)"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // Envoi de la demande à l'API
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                // Traitement de la réponse de l'API
                if let error = error {
                    print("Error : \(error.localizedDescription)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                    print("Not sended")
                    return
                }
                print("UPDATE request denied")
            }
            task.resume()
        }
    }
    
    // http://192.168.1.95:2000/api/deliverer?email=update&password=update&phone=0967398710&longitude=0.00000&latitude=0.0000&name=addName&firstname=addFirstname&photo&evaluation=2&total=2930.3&longitude=2873.92892&latitude=372.302
    
    func addDeliverer(id: Int, email: String, password: String, phone: String,
                      longitude: String, latitude: String, name: String, firstname: String, photo: String,
                      evaluation: String, total: String,
                      completion: @escaping (Result<DeliverersData, Error>) -> Void){
        // Création de la demande update
        let urlString = apiService.baseUrl+"deliverer?email=\(email)&password=\(password)&phone=\(phone)&longitude=\(longitude)&latitude=\(latitude)&name=\(name)&firstname=\(firstname)&photo=\(photo)&evaluation=\(evaluation)&total=\(total)"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Envoi de la demande à l'API
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                // Traitement de la réponse de l'API
                if let error = error {
                    print("Error : \(error.localizedDescription)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Not sended")
                    return
                }
                print("UPDATE request denied")
            }
            task.resume()
        }
    }
}
