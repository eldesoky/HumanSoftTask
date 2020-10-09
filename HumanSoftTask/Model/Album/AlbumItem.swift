//
//  AlbumItem.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import Foundation

public struct AlbumItem: Codable {
    public let id: Int
    public let title: String
    public let albumId: Int
    public let url: String
    public let thumbnailUrl: String

    public init(id: Int,
                title: String,
                albumId: Int,
                url: String,
                thumbnailUrl: String) {
        self.id = id
        self.title = title
        self.albumId = albumId
        self.url = url
        self.thumbnailUrl = thumbnailUrl

    }
}

extension AlbumItem: Equatable {
    public static func == (lhs: AlbumItem, rhs: AlbumItem) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.albumId == rhs.albumId &&
            lhs.url == rhs.url &&
            lhs.thumbnailUrl == rhs.thumbnailUrl
    }
}
