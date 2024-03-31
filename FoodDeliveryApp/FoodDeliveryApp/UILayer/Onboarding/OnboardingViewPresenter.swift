//
//  OnboardingViewPresenter.swift
//  FoodDeliveryApp
//
//  Created by Vova Lincore on 31.03.2024.
//

import Foundation

protocol OnboardingViewOutput: AnyObject {
    func onboardingFinish()
}

class OnboardingViewPresenter: OnboardingViewOutput {
    func onboardingFinish() {
        coordinator.finish()
    }
    
    // MARK: - Properties
    weak var coordinator: OnboardingCoordinator!
    
    init(coordinator: OnboardingCoordinator!) {
        self.coordinator = coordinator
    }
}

