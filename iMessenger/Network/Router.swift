//
//  Router.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 07/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Router{
    static var instance: Router?
    
    static func sharedInstance() -> Router {
        if self.instance == nil {
            self.instance = Router()
        }
        return self.instance!
    }
    
    let baseURL = "http://info121.sytes.net/RestAPIInfoMessage/MyLimoService.svc/"
    
    func ValidateUser(deviceId: String, fcmToken: String,
                      success:@escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
        
        let url = String(format: "%@%@/%@,%@,%@,%@", baseURL, "validateuser", deviceId, fcmToken, getSecretKey(), getMobileKey())
        
        
        AF.request(url)
            .response{
                (responseData) in
                
                guard let data = responseData.data else {return}
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    print(objRes)
                    success(objRes)
                }catch{
                    failure("Failure")
                }
                
                
        }
        
    }
}




