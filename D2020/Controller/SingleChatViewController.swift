//
//  ChatViewController.swift
//  Chat
//
//  Created by Macbook on 21/06/2021.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Alamofire
import KRProgressHUD

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

class SingleChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate  {
    let currentUser = Sender(senderId: "self", displayName: " ")
    var otherUser = Sender(senderId: "other", displayName: " ")
    let dateFormatter = DateFormatter()

    var messages = [Message]()
    var messagesArray = [MessagesData]()


    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource =  self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
//
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        messageInputBar.delegate = self
        getSingleMessage()
    }
    
    

    func currentSender() -> SenderType {
        currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
//        return messagesArray[indexPath.section] as! MessageType
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
//        return messagesArray.count
    }
    func getSingleMessage(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/messages/1"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                guard let weakSelf = self else{ return }
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(SingleMessage.self, from: result.data!) else{return}
                self?.messagesArray = apiResponseModel.data ?? [MessagesData]()
                self?.messages = self?.messagesArray.map{ Message(sender: $0.status == "send" ? weakSelf.currentUser : weakSelf.otherUser, messageId: UUID().uuidString, sentDate: weakSelf.dateFormatter.date(from: $0.date ?? "") ?? Date(), kind: .text($0.message ?? "")) } ?? [Message]()
                self?.messagesCollectionView.reloadData()
                KRProgressHUD.dismiss()
            }
    }
    
    
    
      

}

extension SingleChatViewController: InputBarAccessoryViewDelegate{
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
//    func addMessage(){
//        KRProgressHUD.show()
////        let requestParameters = ["subject": subject ?? "","message": message ?? "", "stage_id": stage_id ?? ""]
//
//        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
//        let headers = ["Authorization":"Bearer \(token)"]
//        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/messages/send_text_to/1"
//        print("URL : \(apiURLInString)")
//
//        guard let apiURL = URL(string: apiURLInString) else{ return }
//        Alamofire
//            .request(apiURL, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers)
//            .response {[weak self] result in
//                print("Response Code : \(result.response?.statusCode)")
//                if result.response?.statusCode == 200{
//                    KRProgressHUD.showSuccess(withMessage: "تم تعديل كلمة المرور بنجاح")
//                }else{
//                    KRProgressHUD.showError(withMessage: "كلمة المرور القديمة غير صحيحة")
//                }
//
//            }
//    }
    
    
 
    
 
    

}
