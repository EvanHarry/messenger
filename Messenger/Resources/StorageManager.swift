//
//  StorageManager.swift
//  Messenger
//
//  Created by Evan Harry on 10/07/2020.
//  Copyright © 2020 Evan Harry. All rights reserved.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    ///Uploads picture to firebase storage and returns completion with url string to download
    public func uploadProfilePicture(with data: Data, filename: String, completion: @escaping UploadPictureCompletion) {
        
        storage.child("images/\(filename)").putData(data, metadata: nil) { (metadata, error) in
            
            guard error == nil else {
                
                completion(.failure(StorageErrors.failedToUpload))
                
                return
                
            }
            
            self.storage.child("images/\(filename)").downloadURL { (url, error) in
                
                guard let url = url else {
                    
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    
                    return
                    
                }
                
                let urlString = url.absoluteString
                
                completion(.success(urlString))
                
            }
            
        }
        
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
    
}
