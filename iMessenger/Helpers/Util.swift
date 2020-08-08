//
//  Util.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 05/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import UIKit



func getDeviceID()->String{
    if let uuid = UIDevice.current.identifierForVendor?.uuidString{
        return uuid
    }
    return ""
}


func getSecretKey()->String{
    let currentDate = Date()
    
    let format = DateFormatter()
    format.timeZone = .some(TimeZone(abbreviation: "UTC+08")!)
    
    // 3) Set the format of the altered date.
    format.dateFormat = "ddMMyyyy"
    
    return "info121" + format.string(from: currentDate)
}

func getMobileKey()->String{
    let currentDate = Date()
    
    // 1) Create a DateFormatter() object.
    let format = DateFormatter()
    
    // 2) Set the current timezone to SG
    format.timeZone = .some(TimeZone(abbreviation: "UTC+08")!)
    
    // 3) Set the format of the altered date.
    format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    format.dateFormat = "dd"
    let dd = format.string(from: currentDate)
    
    format.dateFormat = "MM"
    let mm = format.string(from: currentDate)
    
    format.dateFormat = "yyyy"
    let yyyy = format.string(from: currentDate)
    
    format.dateFormat = "HH"
    let hh = format.string(from: currentDate)
    
    
    // 4) Set the current date, altered by timezone.
    let dateString = "1" + dd + mm + yyyy + hh
    var specialKey = ""
    
    print(dateString)
    
    for char in dateString{
        specialKey+=convertChars(chr : "\(char)")
    }
    
    return specialKey
    
}


func convertChars(chr: String)->String{
    
    // 1) Create a DateFormatter() object.
    let format = DateFormatter()
    
    // 2) Set the current timezone to .current, or America/Chicago.
    format.timeZone = .some(TimeZone(abbreviation: "UTC+08")!)
    
    format.dateFormat = "hh"
    let hh = format.string(from: Date())
    
    var ret = ""
    
    if (hh=="01") {
        if (chr=="0") {
            ret = "f";
        }
        if (chr=="1") {
            ret = "s";
        }
        if (chr=="2") {
            ret = "v";
        }
        if (chr=="3") {
            ret = "q";
        }
        if (chr=="4") {
            ret = "n";
        }
        if (chr=="5") {
            ret = "j";
        }
        if (chr=="6") {
            ret = "h";
        }
        if (chr=="7") {
            ret = "b";
        }
        if (chr=="8") {
            ret = "r";
        }
        if (chr=="9") {
            ret = "i";
        }
    }
    if (hh=="02") {
        if (chr=="0") {
            ret = "x";
        }
        if (chr=="1") {
            ret = "b";
        }
        if (chr=="2") {
            ret = "l";
        }
        if (chr=="3") {
            ret = "j";
        }
        if (chr=="4") {
            ret = "c";
        }
        if (chr=="5") {
            ret = "n";
        }
        if (chr=="6") {
            ret = "k";
        }
        if (chr=="7") {
            ret = "h";
        }
        if (chr=="8") {
            ret = "v";
        }
        if (chr=="9") {
            ret = "m";
        }
    }
    if (hh=="03") {
        if (chr=="0") {
            ret = "q";
        }
        if (chr=="1") {
            ret = "w";
        }
        if (chr=="2") {
            ret = "e";
        }
        if (chr=="3") {
            ret = "r";
        }
        if (chr=="4") {
            ret = "a";
        }
        if (chr=="5") {
            ret = "s";
        }
        if (chr=="6") {
            ret = "d";
        }
        if (chr=="7") {
            ret = "f";
        }
        if (chr=="8") {
            ret = "z";
        }
        if (chr=="9") {
            ret = "x";
        }
    }
    if (hh=="04") {
        if (chr=="0") {
            ret = "g";
        }
        if (chr=="1") {
            ret = "b";
        }
        if (chr=="2") {
            ret = "t";
        }
        if (chr=="3") {
            ret = "u";
        }
        if (chr=="4") {
            ret = "h";
        }
        if (chr=="5") {
            ret = "n";
        }
        if (chr=="6") {
            ret = "y";
        }
        if (chr=="7") {
            ret = "i";
        }
        if (chr=="8") {
            ret = "j";
        }
        if (chr=="9") {
            ret = "m";
        }
    }
    if (hh=="05") {
        if (chr=="0") {
            ret = "o";
        }
        if (chr=="1") {
            ret = "y";
        }
        if (chr=="2") {
            ret = "e";
        }
        if (chr=="3") {
            ret = "q";
        }
        if (chr=="4") {
            ret = "i";
        }
        if (chr=="5") {
            ret = "t";
        }
        if (chr=="6") {
            ret = "w";
        }
        if (chr=="7") {
            ret = "a";
        }
        if (chr=="8") {
            ret = "u";
        }
        if (chr=="9") {
            ret = "r";
        }
    }
    if (hh=="06") {
        if (chr=="0") {
            ret = "h";
        }
        if (chr=="1") {
            ret = "c";
        }
        if (chr=="2") {
            ret = "w";
        }
        if (chr=="3") {
            ret = "j";
        }
        if (chr=="4") {
            ret = "r";
        }
        if (chr=="5") {
            ret = "a";
        }
        if (chr=="6") {
            ret = "m";
        }
        if (chr=="7") {
            ret = "s";
        }
        if (chr=="8") {
            ret = "t";
        }
        if (chr=="9") {
            ret = "y";
        }
    }
    if (hh=="07") {
        if (chr=="0") {
            ret = "p";
        }
        if (chr=="1") {
            ret = "z";
        }
        if (chr=="2") {
            ret = "h";
        }
        if (chr=="3") {
            ret = "y";
        }
        if (chr=="4") {
            ret = "j";
        }
        if (chr=="5") {
            ret = "t";
        }
        if (chr=="6") {
            ret = "f";
        }
        if (chr=="7") {
            ret = "x";
        }
        if (chr=="8") {
            ret = "q";
        }
        if (chr=="9") {
            ret = "m";
        }
    }
    if (hh=="08") {
        if (chr=="0") {
            ret = "g";
        }
        if (chr=="1") {
            ret = "t";
        }
        if (chr=="2") {
            ret = "u";
        }
        if (chr=="3") {
            ret = "f";
        }
        if (chr=="4") {
            ret = "s";
        }
        if (chr=="5") {
            ret = "x";
        }
        if (chr=="6") {
            ret = "n";
        }
        if (chr=="7") {
            ret = "e";
        }
        if (chr=="8") {
            ret = "d";
        }
        if (chr=="9") {
            ret = "q";
        }
    }
    if (hh=="09") {
        if (chr=="0") {
            ret = "n";
        }
        if (chr=="1") {
            ret = "x";
        }
        if (chr=="2") {
            ret = "s";
        }
        if (chr=="3") {
            ret = "y";
        }
        if (chr=="4") {
            ret = "w";
        }
        if (chr=="5") {
            ret = "j";
        }
        if (chr=="6") {
            ret = "k";
        }
        if (chr=="7") {
            ret = "f";
        }
        if (chr=="8") {
            ret = "p";
        }
        if (chr=="9") {
            ret = "q";
        }
    }
    if (hh=="10") {
        if (chr=="0") {
            ret = "g";
        }
        if (chr=="1") {
            ret = "b";
        }
        if (chr=="2") {
            ret = "u";
        }
        if (chr=="3") {
            ret = "j";
        }
        if (chr=="4") {
            ret = "r";
        }
        if (chr=="5") {
            ret = "x";
        }
        if (chr=="6") {
            ret = "q";
        }
        if (chr=="7") {
            ret = "i";
        }
        if (chr=="8") {
            ret = "s";
        }
        if (chr=="9") {
            ret = "d";
        }
    }
    if (hh=="11") {
        if (chr=="0") {
            ret = "j";
        }
        if (chr=="1") {
            ret = "a";
        }
        if (chr=="2") {
            ret = "b";
        }
        if (chr=="3") {
            ret = "c";
        }
        if (chr=="4") {
            ret = "d";
        }
        if (chr=="5") {
            ret = "e";
        }
        if (chr=="6") {
            ret = "f";
        }
        if (chr=="7") {
            ret = "g";
        }
        if (chr=="8") {
            ret = "h";
        }
        if (chr=="9") {
            ret = "i";
        }
    }
    
    if (hh=="12" || hh=="00") {
        if (chr=="0") {
            ret = "n";
        }
        if (chr=="1") {
            ret = "y";
        }
        if (chr=="2") {
            ret = "x";
        }
        if (chr=="3") {
            ret = "j";
        }
        if (chr=="4") {
            ret = "v";
        }
        if (chr=="5") {
            ret = "a";
        }
        if (chr=="6") {
            ret = "s";
        }
        if (chr=="7") {
            ret = "q";
        }
        if (chr=="8") {
            ret = "e";
        }
        if (chr=="9") {
            ret = "l";
        }
    }
    
    return ret
}

func showMessage(msg: String)->String{
    return msg;
}
