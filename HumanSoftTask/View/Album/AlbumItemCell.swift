//
//  AlbumItemCell.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import UIKit

class AlbumItemCell: UICollectionViewCell {

    @IBOutlet weak var itemImage: UIImageView!

    func config(_ url:String) {
        let newUrl = URL(string: url)
        itemImage.kf.setImage(with: newUrl)
    }
}
