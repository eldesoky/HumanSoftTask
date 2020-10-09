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
    
    private static func archiveUser(_ user : User) -> Data {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
            
            return data
        } catch {
            fatalError("Can't encode data: \(error)")
        }
        
    }
    
    static func load() -> User? {
        
        if let unarchivedObject = UserDefaults.standard.object(forKey: UserKey) as? Data {
            do {
                return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedObject as Data) as? User
            } catch {
                print(error)
                return nil
            }
        }
        return nil
    }
    
    static func save(_ user : User?) {
        let archivedObject = archiveUser(user!)
        UserDefaults.standard.set(archivedObject, forKey: UserKey)
        UserDefaults.standard.synchronize()
    }
    
    static func remove() {
        UserDefaults.standard.removeObject(forKey: UserKey)
        UserDefaults.standard.synchronize()
    }
    
    static func isActive() -> Bool {
        return (UserUtil.load() != nil && UserUtil.load()?.id != nil)
    }
    
    
}

