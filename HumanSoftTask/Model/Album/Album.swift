//
//  Album.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import Foundation

public struct Album: Codable {
    public let id: String
    public let title: String
    public let userId: String

    public init(id: String,
                title: String,
                userId: String) {
        self.id = id
        self.title = title
        self.userId = userId
    }
}

extension Album: Equatable {
    public static func == (lhs: Album, rhs: Album) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.userId == rhs.userId
    }
}
