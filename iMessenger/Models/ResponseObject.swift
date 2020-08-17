//
//  ObjectResponse.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 06/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import Foundation

struct ResponseObject: Codable {
//    var isUnderMaintenance: String?
//    var levelDetails: String?
//    var levelNotCheckedDetails: String?
//    var messageDetails: String?
//    var profileDetails: String?
//    var roundsDetails: String?
//    var unitDetails: String?
//    var userHP: String?
//    var version: String?
//    var lastlogin: String?
//    var responsemessage: String?
//    var status: String?
//    var token: String?
    
    var IsUnderMaintenance: String?
    var LevelDetails: String?
    var LevelNotCheckedDetails: String?
    let MessageDetails: [MessageDetail]?
    var ProfileDetails: [ProfileDetail]?
    var RoundsDetails: String?
    var UnitDetails: String?
    var UserHP: String?
    var Version: String?
    var lastlogin: String?
    var responsemessage: String?
    var status: String?
    var token: String?
}
