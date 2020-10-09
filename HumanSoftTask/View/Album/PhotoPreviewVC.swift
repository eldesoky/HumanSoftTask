//
//  PhotoPreviewVC.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoPreviewVC: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var albumItem: AlbumItem?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = albumItem?.title
        let newUrl = URL(string: albumItem?.url ?? "")
        imageView.kf.setImage(with: newUrl)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(closeAction))
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
    }
    
    @objc func closeAction() {
        self.dismiss(animated: true)
    }

}

extension PhotoPreviewVC: UIScrollViewDelegate {
        
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
