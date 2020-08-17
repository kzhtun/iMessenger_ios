//
//  ViewController.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 05/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class MainViewController: UIViewController {
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let App = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidAppear(_ animated: Bool) {
        //        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //               let registerVC = storyBoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        //
        //                              registerVC.modalPresentationStyle = .fullScreen
        //                              self.present(registerVC, animated: true, completion: nil)
        //
        //
        //           print("Load Register VC")
        
        validateUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        print(getDeviceID())
        print(getSecretKey())
        print(getMobileKey())
        
        
    }
    
   
    
    public func getUserHP(){
        Router.sharedInstance().GetUserHP(deviceId: getDeviceID(),  success: {
            (successObject) in
            if( successObject.responsemessage?.uppercased() == "VALID"){
                self.App.MOBILE_NO = successObject.UserHP!.replacingOccurrences(of: "+65", with: "")
               
                
                // present Messages Screen
                let messageVC = self.storyBoard.instantiateViewController(withIdentifier: "MessageVC") as! MessageViewController
                
                messageVC.modalPresentationStyle = .fullScreen
                self.present(messageVC, animated: true, completion: nil)
                
            }else{
                self.view.makeToast("Error when getting mobile number")
            }
        }, failure: {
            (failureObject) in
            print(failureObject as Any)
        })
    }
    
    private func validateUser(){
        Router.sharedInstance().ValidateUser(deviceId: getDeviceID(), fcmToken: App.FCM_TOKEN, success: {
            (successObject) in
            
            // open Register Screen
            if( successObject.responsemessage?.uppercased() == "INVALID"){
                self.view.makeToast("Device is not register yet.")
                let registerVC = self.storyBoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
                
                registerVC.modalPresentationStyle = .fullScreen
                self.present(registerVC, animated: true, completion: nil)
                
            }else{ // open Message List Screen
                self.view.makeToast("Registered device found.")
                self.App.AUT_TOKEN = successObject.token!
                self.getUserHP()
                
            }
            
            print(successObject)
            
            
        }, failure: {
            (failureObject) in
            print(failureObject as Any)
        })
        
    }
}

//    func validateUser(){
//        DispatchQueue.main.async {
//
//            let url = self.App.REST_API_URL + "validateuser" + "/"
//                + getDeviceID() + ","
//                + "a" + ","
//                + getSecretKey() + ","
//                + getMobileKey()()
//
//
//            print(url)
//
//            AF.request( url
//                , method: .get).responseJSON{
//                    (respone) in
//
//
//                    switch respone.result{
//
//                    case .success(let value):
//                        let json = JSON(value)
//                        print(json)
//
//                    case .failure(let error):
//                        print("ERROR :" + error.localizedDescription)
//                    }
//            }
//        }
//    }


