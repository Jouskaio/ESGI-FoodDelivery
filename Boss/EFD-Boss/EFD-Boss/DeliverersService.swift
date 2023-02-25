//
//  DeliverersService.swift
//  EFD-Boss
//
//  Created by Manon Salsou on 25/02/2023.
//

import Foundation

protocol DeliverersService {
    func add(deliverer: Deliverer, _ completion: @escaping (Error?) -> Void) // le @escaping permet de déclencher le fonction après traitement s'il y a une erreur (mettre la fonction temporairement de coté le temps du traitement puis l'exécuter à la fin)

    func getBy(id: Int, _ completion: @escaping (Error?, [Deliverer]?) -> Void)
    func clear(_ completion: @escaping (Error?) -> Void)
}

class DeliverersInMemoryService: DeliverersService {
    var deliverers: [Deliverer] = []

    func add(deliverer: Deliverer, _ completion: @escaping (Error?) -> Void) {
        self.deliverers.append(deliverer)
        completion(nil)
    }

    func getBy(id: Int, _ completion: @escaping (Error?, [Deliverer]?) -> Void) {
        let idDeliverer = self.deliverers.filter { deliverer in
            return deliverer.id_deliverer==id
        }
        completion(nil, idDeliverer)
    }

    func clear(_ completion: @escaping (Error?) -> Void) {
        self.deliverers = []
        completion(nil)
    }
    
}
