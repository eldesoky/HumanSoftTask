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

    public init(street: String) {
        self.street = street
    }
    
    private enum CodingKeys: String, CodingKey {
        case street
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decode(String.self, forKey: .street)
 
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(street, forKey: .street)
      }
}

extension UserAddress: Equatable {
    public static func == (lhs: UserAddress, rhs: UserAddress) -> Bool {
        return lhs.street == rhs.street
    }
}
