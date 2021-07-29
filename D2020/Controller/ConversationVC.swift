//
//  ConversationVC.swift
//  Chat
//
//  Created by Macbook on 21/06/2021.
//

import UIKit
import KRProgressHUD
import Alamofire


class ConversationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    

    @IBOutlet weak var tableView: UITableView!
    var chatsArray = [MessageDetails]()
    var stageId: Int? = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        showOwnerChatsWithUsers()
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
        let vc = SingleChatViewController()
        vc.title = "chat"
        vc.stageId = chatsArray[indexPath.row].stageID
        navigationController?.pushViewController(vc, animated: true)
    }
    func showOwnerChatsWithUsers(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)owner/messages_with_users"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        let token = UserDefaults.standard.string(forKey: UserDefaultKey.USER_AUTHENTICATION_TOKEN.rawValue) ?? ""
        let headers = ["Authorization":"Bearer \(token)"]
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: headers)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(OwnerMessagesWithUsers.self, from: result.data!) else{return}
                self?.chatsArray = apiResponseModel.messages ?? [MessageDetails]()
                print(apiResponseModel.messages)
                self?.tableView.reloadData()
                KRProgressHUD.dismiss()

            }
    }
  

    

}
