//
//  ConversationVC.swift
//  Chat
//
//  Created by Macbook on 21/06/2021.
//

import UIKit

class ConversationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
//        setContacts()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "rahma"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // show messages
        let vc = ChatViewController()
        vc.title = "chat"
        navigationController?.pushViewController(vc, animated: true)
    }
//    func setContacts(){
//        let db = Firestore.firestore()
//        db.collection("Chat").getDocuments() { (querySnapshot, err) in
//            print("connected")
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                    print("ok")
//                }
//
//            }
//        }
//    }
  

    

}
