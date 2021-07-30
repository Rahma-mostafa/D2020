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
    var stageId: Int?
    var messages = [Message]()
    var messagesArray = [MessagesData]()
    var timer = Timer()
    var imagePicker = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputButton()
        messagesCollectionView.messagesDataSource =  self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        messageInputBar.delegate = self
//        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getSingleMessage), userInfo: nil, repeats: true)
        getSingleMessage()
        
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
    func setupInputButton() {
        let button = InputBarButtonItem()
        button.setSize(CGSize(width: 36, height: 36), animated: false)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.setStackViewItems([button], forStack: .left, animated: false)
    }
    @objc func chooseImage(){
        let imageSelectionAlert = UIAlertController(title: "اختار مصدر الصورة", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "الكاميرا", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "معرض الصور", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "الغاء", style: .cancel)
        imageSelectionAlert.addAction(cameraAction)
        imageSelectionAlert.addAction(galleryAction)
        imageSelectionAlert.addAction(cancelAction)
        imageSelectionAlert.popoverPresentationController?.sourceView = self.view
        
        self.present(imageSelectionAlert, animated: true, completion: nil)
    }
    func openCamera(){
        imagePicker.sourceType = .camera
        imagePicker.modalPresentationStyle = .overFullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func openGallery(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .overFullScreen
        self.present(imagePicker, animated: true, completion: nil)
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
       func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String){
            addMessage(msg: text)
       }
      func configure() {
         let button = InputBarButtonItem()
         button.setSize(CGSize(width: 36, height: 36), animated: false)
         button.setImage(#imageLiteral(resourceName: "ic_up").withRenderingMode(.alwaysTemplate), for: .normal)
         button.imageView?.contentMode = .scaleAspectFit
         button.tintColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
//         sendButton.setSize(CGSize(width: 52, height: 36), animated: false)
     }
  

    
    func addMessage(msg:String){
        KRProgressHUD.show()
        let requestParameters = ["subject": msg ,"message": msg , "stage_id": stageId ?? ""] as [String : Any]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/messages/send_text_to/1"
        print("URL : \(apiURLInString)")
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .post, parameters: requestParameters, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
                if result.response?.statusCode == 200{
                    KRProgressHUD.showSuccess(withMessage: "تم الارسال")
                }else{
                    KRProgressHUD.showError(withMessage: "فشل العملية")
                }
            }
    }
    func addImage(msg:String){
        KRProgressHUD.show()
        let requestParameters = ["image": msg , "stage_id": stageId ?? ""] as [String : Any]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/messages/send_image_to/1"
        print("URL : \(apiURLInString)")
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .post, parameters: requestParameters, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                print("Response Code : \(result.response?.statusCode)")
                if result.response?.statusCode == 200{
                    KRProgressHUD.showSuccess(withMessage: "تم الارسال")
                }else{
                    KRProgressHUD.showError(withMessage: "فشل العملية")
                }
            }
    }
    
    
    
 
    
 
    

}
