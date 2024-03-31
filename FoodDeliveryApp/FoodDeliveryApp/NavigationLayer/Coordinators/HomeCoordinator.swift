//
//  HomeCoordinator.swift
//  FoodDeliveryApp
//
//  Created by Vova Lincore on 31.03.2024.
//

import UIKit

class HomeCoordinator: Coordinator {
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .red
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("HomeCoordinator finish")
    }
}

