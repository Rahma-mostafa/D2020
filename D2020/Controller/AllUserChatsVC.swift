//
//  AllUserChatsVC.swift
//  D2020
//
//  Created by Macbook on 31/07/2021.
//

import UIKit
import KRProgressHUD
import Alamofire

class AllUserChatsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var chatsArray = [MessageDetails]()
    var userName: String? = ""
    var stageId: String? = ""
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        getDifferentChats()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = chatsArray[indexPath.row].subject
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // show messages
        let vc = singleUserMessageVC()
        vc.title = "chat"
        vc.stageId = String(chatsArray[indexPath.row].stageID ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
  
   
    func showOwnerChatsWithOwner(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/messages_with_owners"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(OwnerMessagesWithUsers.self, from: result.data!) else{return}
                self?.chatsArray = apiResponseModel.messages ?? [MessageDetails]()
                self?.userName = apiResponseModel.username
                self?.tableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    func showOwnerChatsWithAdmin(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/messages"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(OwnerMessagesWithUsers.self, from: result.data!) else{return}
                self?.chatsArray = apiResponseModel.messages ?? [MessageDetails]()
                self?.userName = apiResponseModel.username
                self?.tableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    func showOwnerChatsWithDelegate(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/messages_with_del"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(OwnerMessagesWithUsers.self, from: result.data!) else{return}
                self?.chatsArray = apiResponseModel.messages ?? [MessageDetails]()
                self?.userName = apiResponseModel.username
                self?.tableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
    func getDifferentChats(){
        if type == "owner"{
            showOwnerChatsWithOwner()
        }else if type == "admin"{
            showOwnerChatsWithAdmin()
        }else{
            showOwnerChatsWithDelegate()
        }
    }

    

}
