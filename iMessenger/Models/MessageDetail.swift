//
//  MessageDetails.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 12/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import Foundation

struct MessageDetail: Codable {
    var GroupID, MessageID, Messages, MsgDate: String?
    var MsgStatus, Sender, SenderID: String?
    
    init(msgDate: String, msgStatus: String){
        MsgDate = msgDate
        MsgStatus = msgStatus
    }
}
