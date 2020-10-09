//
//  PhotoPreviewCoordinator.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import UIKit

class PhotoPreviewCoordinator: Coordinator {
    
    private var presenter: UINavigationController
    private var albumItem: AlbumItem
    
    init(presenter: UINavigationController, albumItem: AlbumItem) {
        self.presenter = presenter
        self.albumItem = albumItem
    }
    
    func start() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let photoPreviewVC = storyboard.instantiateViewController(withIdentifier:  "PhotoPreviewVC") as! PhotoPreviewVC
        photoPreviewVC.albumItem = albumItem
        presenter.present(UINavigationController(rootViewController: photoPreviewVC), animated: true, completion: nil)
    }
    
}
