//
//  ViewController.swift
//  Messenger
//
//  Created by Evan Harry on 07/07/2020.
//  Copyright © 2020 Evan Harry. All rights reserved.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check if the user is signed in.
        validateAuth()
        
    }
    
    private func validateAuth() {
        
        let auth = Auth.auth()
        
        if auth.currentUser == nil {
            
            let vc = LoginViewController()
            
            // In iOS 13, the default presentation style is dismissible card, we don't want the login screen to be dismissible so set presentation style to fullscreen.
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            
            present(nav, animated: false)
            
        } else {
            
            auth.currentUser?.reload(completion: { (error) in
                
                if error != nil {
                    
                    do {
                        try auth.signOut()
                    } catch {
                        return
                    }
                    
                    self.validateAuth()
                    
                }
                
            })
            
        }
        
    }

}
