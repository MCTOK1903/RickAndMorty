//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var service: ServiceType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        service = Services()
        
        service?.filterCharacter(characterStatus: .dead) { (result) in
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}

