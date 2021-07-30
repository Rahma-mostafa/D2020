//
//  ChatKitModels.swift
//  D2020
//
//  Created by Macbook on 30/07/2021.
//

import Foundation
import MessageKit

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

