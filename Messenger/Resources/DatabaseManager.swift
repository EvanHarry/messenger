//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Evan Harry on 07/07/2020.
//  Copyright © 2020 Evan Harry. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

// MARK: - Account Management

extension DatabaseManager {
    
    /// Checks whether a user already exists in the database with the provided email
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { (snapshot) in
            
            guard snapshot.value as? String != nil else {
                
                completion(false)
                
                return
                
            }
            
            completion(true)
            
        }
        
    }
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        
        database.child(user.safeEmail).setValue(["firstName": user.firstName, "lastName": user.lastName])
        
    }
    
}

struct ChatAppUser {
    
    let firstName: String
    let lastName: String
    let email: String
    // let profileUrl: String
    
    var safeEmail: String {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        return safeEmail
    }
    
}
