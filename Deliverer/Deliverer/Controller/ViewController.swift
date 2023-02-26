//
//  ViewController.swift
//  Deliverer
//
//  Created by Maaz TAGELDIN on 11/02/2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(
             self,
             tableName: "Main",
             bundle: .main,
             value: self,
             comment: self
        )
    }
}

