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

class SingleChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    let currentUser = Sender(senderId: "self", displayName: " ")
    var otherUser = Sender(senderId: "other", displayName: " ")
    let dateFormatter = DateFormatter()
    var stageId: String?
    var messages = [Message]()
    var messagesArray = [MessagesData]()
    var AdminMessagesArray = [AdminMessage]()
    var timer = Timer()
    var imagePicker = UIImagePickerController()
    var fileURL: URL?
    var contact = ""



    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputButton()
        messagesCollectionView.messagesDataSource =  self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        messageInputBar.delegate = self
//        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getSingleMessage), userInfo: nil, repeats: true)
        imagePicker.delegate = self
        getDifferentChats()

        
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
//            self.addImage()
            
        }
        let galleryAction = UIAlertAction(title: "معرض الصور", style: .default){
            UIAlertAction in
            self.openGallery()
//            self.addImage()

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
     func getSingleMessageForUser(){
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
                self?.messages = self?.messagesArray.map{[weak self] in Message(sender: $0.status == "send" ? weakSelf.currentUser : weakSelf.otherUser, messageId: UUID().uuidString, sentDate: weakSelf.dateFormatter.date(from: $0.date ?? "") ?? Date(), kind: $0.type == "image" ? .photo(MessageImage(image: self!.downloadImage(with: APIConstant.BASE_IMAGE_URL.rawValue + ($0.file ?? "")))) : .text($0.message ?? "")) } ?? [Message]()
                self?.messagesCollectionView.reloadData()
                KRProgressHUD.dismiss()
            }
    }
    
    private func downloadImage(with urlImage: String?)->UIImage{
        guard let urlImage = urlImage else{ return UIImage() }
        guard let url = URL(string: urlImage) else{ return UIImage() }
        guard let data = try? Data(contentsOf: url) else{ return UIImage() }
        guard let image = UIImage(data: data) else{ return UIImage() }
        return image
        
    }
    
    func getAdminMessages(){
       KRProgressHUD.show()
       let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/messages"
       guard let apiURL = URL(string: apiURLInString) else{ return }
       let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
       let headers = ["Authorization":"Bearer \(token)"]
       Alamofire
           .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: headers)
           .response {[weak self] result in
               guard let weakSelf = self else{ return }
               let jsonConverter = JSONDecoder()
            guard let apiResponseModel = try? jsonConverter.decode(SingleAdminMessage.self, from: result.data!) else{return}
//            self?.AdminMessagesArray = apiResponseModel
            self?.messages = self?.AdminMessagesArray.map{[weak self] in Message(sender: $0.status == "send" ? weakSelf.currentUser : weakSelf.otherUser, messageId: UUID().uuidString, sentDate: weakSelf.dateFormatter.date(from: $0.date ?? "") ?? Date(), kind: $0.type == "image" ? .photo(MessageImage(image: self!.downloadImage(with: $0.file))) : .text($0.message ?? "")) } ?? [Message]()
            
               self?.messagesCollectionView.reloadData()
               KRProgressHUD.dismiss()
           }
   }
    func getDifferentChats(){
        if contact == "ownerChatWithAdmin"{
            getAdminMessages()
        }else{
            getSingleMessageForUser()
        }
    }
    func addMessageToUser(msg:String){
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
    func addMessageToAdmin(msg:String){
        KRProgressHUD.show()
        let requestParameters = ["subject": msg ,"message": msg , "stage_id": stageId ?? ""] as [String : Any]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/messages/send"
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
    func addImageToUsers(){
        KRProgressHUD.show()
        let requestParameters = ["stage_id": stageId ?? ""] as [String : String]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)","Accept": "application/json","Content-Type" : "multipart/form-data"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/messages/send_image_to/1"
        print("URL : \(apiURLInString)")
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire.upload(multipartFormData: {[weak self] formData in
            for (key,value) in requestParameters{
                formData.append(value.data(using: .utf8) ?? Data(), withName: key)
            }
            if self?.fileURL != nil{

                formData.append((self?.fileURL!)!, withName: "image")
            }

        }, to: apiURL,method: .post,headers: headers) {[weak self] result in
            switch result{
            case .success(let request, _, _):
                print(request.debugDescription)
                print(request.request?.debugDescription)
                if true{
                    request.responseData { data in
                        print("Response : \(data.debugDescription)")
                        if data.response?.statusCode == 200{
                            KRProgressHUD.showSuccess(withMessage: "تم الارسال")
                            self?.getSingleMessageForUser()
                        }else{
                            KRProgressHUD.showError(withMessage: "فشل العملية")
                        }
                    }
                }else{
                    KRProgressHUD.showError(withMessage: "فشل العملية")
                }
            case .failure(_):
                KRProgressHUD.showError(withMessage: "فشل العملية")
            }
        }

    }
    func addImageToAdmin(){
        KRProgressHUD.show()
        let requestParameters = ["stage_id": stageId ?? ""] as [String : String]
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)","Accept": "application/json","Content-Type" : "multipart/form-data"]
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/messages/send_image"
        print("URL : \(apiURLInString)")
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire.upload(multipartFormData: {[weak self] formData in
            for (key,value) in requestParameters{
                formData.append(value.data(using: .utf8) ?? Data(), withName: key)
            }
            if self?.fileURL != nil{

                formData.append((self?.fileURL!)!, withName: "image")
            }

        }, to: apiURL,method: .post,headers: headers) { result in
            switch result{
            case .success(let request, _, _):
                print(request.debugDescription)
                print(request.request?.debugDescription)
                if true{
                    request.responseData { data in
                        print("Response : \(data.debugDescription)")
                        if data.response?.statusCode == 200{
                            KRProgressHUD.showSuccess(withMessage: "تم الارسال")
                        }else{
                            KRProgressHUD.showError(withMessage: "فشل العملية")
                        }
                    }
                }else{
                    KRProgressHUD.showError(withMessage: "فشل العملية")
                }
            case .failure(_):
                KRProgressHUD.showError(withMessage: "فشل العملية")
            }
        }

    }
    
    
    
    
      

}

extension SingleChatViewController: InputBarAccessoryViewDelegate{
    @objc
       func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String){
        if contact == "ownerChatWithAdmin"{
            addMessageToAdmin(msg: text)
        }else{
            addMessageToUser(msg: text)
        }
       }

}
extension SingleChatViewController{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("image.jpg")
        
        // extract image from the picker and save it
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let imageData = pickedImage.jpegData(compressionQuality: 0.4)
            try! imageData?.write(to: imagePath!)
            self.fileURL = imagePath
        }
        addImageToUsers()
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    
}


class MessageImage: MediaItem{
    var url: URL?
    
    var image: UIImage?
    
    var placeholderImage: UIImage
    
    var size: CGSize
    
    init(image: UIImage) {
        self.image = image
        self.size = CGSize(width: 240, height: 240)
        self.placeholderImage = UIImage()
    }
    
}
