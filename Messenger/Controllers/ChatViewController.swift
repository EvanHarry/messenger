//
//  ChatViewController.swift
//  Messenger
//
//  Created by Evan Harry on 10/07/2020.
//  Copyright © 2020 Evan Harry. All rights reserved.
//

import UIKit
import MessageKit

struct Message: MessageType {
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
}

struct Sender: SenderType {
    
    var photoURL: String
    var senderId: String
    var displayName: String
    
}

class ChatViewController: MessagesViewController {
    
    private var messages = [Message]()
    
    private let selfSender = Sender(photoURL: "", senderId: "1", displayName: "Joe Smith")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        // Add dummy messages
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hello World!")))
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hello World, this is a longer message!")))
    }

}

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    func currentSender() -> SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
}
