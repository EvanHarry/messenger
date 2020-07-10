//
//  ViewController.swift
//  Messenger
//
//  Created by Evan Harry on 07/07/2020.
//  Copyright © 2020 Evan Harry. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ConversationsViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let tableView: UITableView = {
        
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
        
    }()
    
    private let noConversationsLabel: UILabel = {
        
        let label = UILabel()
        label.text = "No Conversations!"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapComposeButton))
        
        view.addSubview(tableView)
        view.addSubview(noConversationsLabel)
        
        setupTableView()
        fetchConversations()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check if the user is signed in.
        validateAuth()
        
    }
    
    @objc private func didTapComposeButton() {
        
        let vc = NewConversationViewController()
        
        let navVC = UINavigationController(rootViewController: vc)
        
        present(navVC, animated: true)
        
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
    
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    private func fetchConversations() {
        
        tableView.isHidden = false
        
    }

}

extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World"
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let vc = ChatViewController()
        vc.title = "Jenny Smith"
        vc.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
