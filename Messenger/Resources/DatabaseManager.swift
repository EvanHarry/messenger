//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Evan Harry on 07/07/2020.
//  Copyright © 2020 Evan Harry. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

// MARK: - Account Management

extension DatabaseManager {
    
    /// Checks whether a user already exists in the database with the provided email
    public func userExists(with email: String, completion: @escaping (Bool) -> Void) {
        
        let auth = Auth.auth()
        
        auth.fetchSignInMethods(forEmail: email) { (result, error) in
            
            guard let result = result, result.count == 0 else {
                
                completion(false)
                
                return
                
            }
            
            completion(true)
            
        }
        
    }
    
    /// Inserts new user to database
    public func insertUser(with user: ChatAppUser, completion: @escaping (Bool) -> Void) {
        
        database.child(user.uid).setValue(["firstName": user.firstName, "lastName": user.lastName, "email": user.email], withCompletionBlock: { (error, _) in
            
            guard error == nil else {
                
                completion(false)
                
                return
                
            }
            
            completion(true)
            
        })
        
    }
    
}

struct ChatAppUser {
    
    let firstName: String
    let lastName: String
    let email: String
    let uid: String
    
    var profilePictureFileName: String {
        return "\(uid)_profile_picture.png"
    }
    
}
