//
//  AlbumCoordinator.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import UIKit

class AlbumCoordinator: Coordinator {
    
    private var presenter: UINavigationController
//    private var movieDetailCoordinator: MovieDetailCoordinator?
    private var albumCVC: AlbumCVC?
    private var album: Album
    
    init(presenter: UINavigationController, album: Album) {
        self.presenter = presenter
        self.album = album
    }
    
    func start() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let albumCVC = storyboard.instantiateViewController(withIdentifier:  "AlbumCVC") as! AlbumCVC
        albumCVC.album = album
        self.albumCVC = albumCVC
        presenter.pushViewController(albumCVC, animated: true)
    }
    
}
