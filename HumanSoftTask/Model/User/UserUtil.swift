//
//  UserUtil.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import Foundation

class UserUtil {
    
    private static let UserKey = "User"

    static func load() -> User? {
     
        guard let userData = UserDefaults.standard.data(forKey: UserKey) else { return nil }
        do {
            return try JSONDecoder().decode(User.self, from: userData)
        }
        catch {
            print(error)
            return nil
        }
    }

    
    static func save(_ user : User?) {
        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: UserKey)
            UserDefaults.standard.synchronize()
        }
        catch {
          print(error)
        }
    }
    
    static func remove() {
        UserDefaults.standard.removeObject(forKey: UserKey)
        UserDefaults.standard.synchronize()
    }
    
    static func isActive() -> Bool {
        return (UserUtil.load() != nil && UserUtil.load()?.id != nil)
    }
    
    
}

