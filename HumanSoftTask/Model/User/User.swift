//
//  User.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import Foundation

public struct User: Codable {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String
    public let address: UserAddress
    public let phone: String
    public let website: String

    public init(id: Int,
                name: String,
                username: String,
                email: String,
                address: UserAddress,
                phone: String,
                website: String) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website

    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(UserAddress.self, forKey: .address)
        phone = try container.decode(String.self, forKey: .phone)
        website = try container.decode(String.self, forKey: .website)

    }
}

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.username == rhs.username &&
        lhs.email == rhs.email &&
        lhs.address == rhs.address &&
        lhs.phone == rhs.phone &&
        lhs.website == rhs.website
    }
}
