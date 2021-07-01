//
//  ChatViewController.swift
//  Chat
//
//  Created by Macbook on 21/06/2021.
//

import UIKit
import MessageKit
//import FirebaseFirestore
import InputBarAccessoryView

struct Sender: SenderType{
    var senderId: String
    var displayName: String


}
struct Message: MessageType{
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind


}
struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize


}

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate  {
    let currentUser = Sender(senderId: "self", displayName: "Rahma")
    let otherUser = Sender(senderId: "other", displayName: "Rahma")

    var messages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource =  self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messages.append(Message(sender: currentUser
                                , messageId: "1",
                                sentDate: Date().addingTimeInterval(-2000),
                                kind: .text("hi")))
        messages.append(Message(sender: otherUser
                                , messageId: "2",
                                sentDate: Date().addingTimeInterval(-1000),
                                kind: .text("hello")))
        messageInputBar.delegate = self
    }
    

    func currentSender() -> SenderType {
        currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
    
      

}

extension ChatViewController: InputBarAccessoryViewDelegate{
    @objc
       func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
//            addMessage(msg: text)
       }
    
//    func addMessage(msg: String){
//            var ref: DocumentReference? = nil
//            let db = Firestore.firestore()
//            ref = db.collection("chat").addDocument(data: [
//                "msg": "\(msg)"
//            ]) { err in
//                if let err = err {
//                    print("Error adding document: \(err)")
//                } else {
//                    print("Document added with ID: \(ref!.documentID)")
//                }
//            }
//    }
    
 
    
 
    

}
