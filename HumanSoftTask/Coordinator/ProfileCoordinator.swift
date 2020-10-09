//
//  ProfileCoordinator.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {

    func start() {
        let profileTVC = ProfileTVC()
        let presenter = UINavigationController(rootViewController: profileTVC)
        presenter.navigationBar.prefersLargeTitles = true
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = presenter
    }
    
}
