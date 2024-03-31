//
//  OrderCoordinator.swift
//  FoodDeliveryApp
//
//  Created by Vova Lincore on 31.03.2024.
//

import UIKit

class OrderCoordinator: Coordinator {
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .yellow
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("OrderCoordinator finish")
    }
}

