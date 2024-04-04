//
//  UserStorage.swift
//  FoodDeliveryApp
//
//  Created by Vova Lincore on 02.04.2024.
//

import Foundation

class UserStorage {
    static let shared = UserStorage()
    
    var passedOnboarding: Bool {
        get { UserDefaults.standard.bool(forKey: "passedOnboarding")}
        set { UserDefaults.standard.set(newValue, forKey: "passedOnboarding")}
    }
}
