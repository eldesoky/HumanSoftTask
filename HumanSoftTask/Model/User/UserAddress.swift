//
//  UserAddress.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import Foundation

public struct UserAddress: Codable {
    public let street: String
    public let suite: String
    public let city: String
    public let zipcode: String

    public init(street: String,
                suite: String,
                city: String,
                zipcode: String ) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
    }
    
    var fullAddress: String {
        return self.street + ", " +  self.suite + ", " + self.city + ", " + self.zipcode
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decode(String.self, forKey: .street)
        suite = try container.decode(String.self, forKey: .suite)
        city = try container.decode(String.self, forKey: .city)
        zipcode = try container.decode(String.self, forKey: .zipcode)

    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(street, forKey: .street)
        try container.encode(suite, forKey: .suite)
        try container.encode(city, forKey: .city)
        try container.encode(zipcode, forKey: .zipcode)
    }
}

extension UserAddress: Equatable {
    public static func == (lhs: UserAddress, rhs: UserAddress) -> Bool {
        return lhs.street == rhs.street &&
               lhs.suite == rhs.suite &&
               lhs.city == rhs.city &&
               lhs.zipcode == rhs.zipcode
    }
}
