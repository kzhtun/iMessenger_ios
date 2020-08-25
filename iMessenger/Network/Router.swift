//
//  Router.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 07/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import Foundation
import Alamofire

class Router{
    let App = UIApplication.shared.delegate as! AppDelegate
    static var instance: Router?
    let baseURL = "http://info121.sytes.net/RestAPIInfoMessage/MyLimoService.svc/"
    
    static func sharedInstance() -> Router {
        if self.instance == nil {
            self.instance = Router()
        }
        return self.instance!
    }
    
    
    // @GET("unregisterdevice/{deviceId},{secretKey},{mobileKey}")
    func UnRegisterDevice(deviceId: String,
    success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
    
        let headers: HTTPHeaders = [
                  "driver": getDeviceID(),
                  "token": self.App.AUT_TOKEN
              ]
        
        let url = String(format: "%@%@/%@,%@,%@", baseURL, "unregisterdevice", deviceId, getSecretKey(), getMobileKey())
        
        AF.request(url, headers: headers)
            .response{
                (responseData) in
                guard let data = responseData.data else {return}
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    
                    success(objRes)
                    
                    print("UnRegisterDevice Success")
                }catch{
                    failure("UnRegisterDevice Failed")
                }
        }
    }
    
    // @GET("getUserProfile/{userhp},{secretkey},{mobileKey}")
    func GetUserProfile(userHP: String,
    success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
    
        let headers: HTTPHeaders = [
                  "driver": getDeviceID(),
                  "token": self.App.AUT_TOKEN
              ]
        
        let url = String(format: "%@%@/%@,%@,%@", baseURL, "getUserProfile", userHP, getSecretKey(), getMobileKey())
        
        AF.request(url, headers: headers)
            .response{
                (responseData) in
                guard let data = responseData.data else {return}
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    
                    success(objRes)
                    
                    print("GetUserProfile Success")
                }catch{
                    failure("GetUserProfile Failed")
                }
        }
    }
    
    
    // @GET("updateMessageStatusRead/{messageId},{secretkey},{mobileKey}")
    func UpdateMessageStatus(messageId: String,
                             success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
        
        let headers: HTTPHeaders = [
            "driver": getDeviceID(),
            "token": self.App.AUT_TOKEN
        ]
        
        let url = String(format: "%@%@/%@,%@,%@", baseURL, "updateMessageStatusRead", messageId, getSecretKey(), getMobileKey())
        
        AF.request(url, headers: headers)
            .response{
                (responseData) in
                guard let data = responseData.data else {return}
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    
                    success(objRes)
                    
                    print("UpdateMessageStatus Success")
                }catch{
                    failure("UpdateMessageStatus Failed")
                }
        }
    }
    
    //@GET("getUserHP/{deviceId},{secretKey},{mobileKey}")
    func GetUserHP(deviceId: String,
                   success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
        
        let headers: HTTPHeaders = [
            "driver": getDeviceID(),
            "token": self.App.AUT_TOKEN
        ]
        
        let url = String(format: "%@%@/%@,%@,%@", baseURL, "getUserHP", deviceId, getSecretKey(), getMobileKey())
        
        AF.request(url, headers: headers)
            .response{
                (responseData) in
                guard let data = responseData.data else {return}
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    
                    
                    success(objRes)
                    
                    print("GetUserHP Success")
                }catch{
                    failure("GetUserHP Failed")
                }
        }
    }
    
    //@GET("getUserMessagedate/{userhp},{date},{secretkey},{mobileKey}")
    func GetUserMessagesByDate(mobileNo: String, date: String,
                               success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
        
        let url = String(format: "%@%@/%@,%@,%@,%@", baseURL, "getUserMessagedate", mobileNo, date, getSecretKey(), getMobileKey())
        
        let headers: HTTPHeaders = [
            "driver": getDeviceID(),
            "token": self.App.AUT_TOKEN
        ]
        
        AF.request(url, headers: headers)
            .response{
                (responseData) in
                guard let data = responseData.data else {return}
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    
                    success(objRes)
                    
                    print("GetUserMessagesByDate Success")
                }catch(let error){
                    print(error.localizedDescription)
                    failure("GetUserMessagesByDate Failed")
                }
        }
    }
    
    //@GET("validateuser/{deviceId},{fcmtoken},{secretKey},{mobileKey}")
    func ValidateUser(deviceId: String, fcmToken: String,
                      success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
        
        let url = String(format: "%@%@/%@,%@,%@,%@", baseURL, "validateuser", deviceId, fcmToken, getSecretKey(), getMobileKey())
        
        
        AF.request(url) 
            .response{
                (responseData) in
                guard let data = responseData.data else {return}
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    
                    success(objRes)
                    
                    print("ValidateUser Success")
                }catch(let error){
                    print(error.localizedDescription)
                    failure("ValidateUser Failed")
                }
        }
        
    }
    
    
    //@GET("registeruser/{username},{mobile},{deviceId},{secretKey},{mobileKey}")
    func RegisterUser(userName: String, mobileNo: String, deviceId: String,
                      success: @escaping (_ responseObject: ResponseObject) -> Void, failure: @escaping (_ error: String) -> Void){
        
        let url = String(format: "%@%@/%@,%@,%@,%@,%@", baseURL, "registeruser", userName, mobileNo, deviceId, getSecretKey(), getMobileKey())
        
        AF.request(url)
            .response{
                (responseData) in
                guard let data = responseData.data else {return}
                do{
                    let objRes = try JSONDecoder().decode(ResponseObject.self, from: data)
                    
                    success(objRes)
                    
                    print("RegisterUser Success")
                }catch(let error){
                    print(error.localizedDescription)
                    print("RegisterUser Failed")
                }
        }
    }
    
}




