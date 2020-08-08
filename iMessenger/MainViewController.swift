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
    
    
    let App = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(getDeviceID())
        print(showMessage(msg: "Global Hello"))
        
        print(getSecretKey())
        print(getMobileKey())
        
        Router.sharedInstance().ValidateUser(deviceId: getDeviceID(), fcmToken: App.FCM_TOKEN, success: {
            (successObject) in
            
             let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            // open Register Screen
            if( successObject.responsemessage?.uppercased() == "INVALID"){
                let registerVC = storyBoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
                
                registerVC.modalPresentationStyle = .fullScreen
                self.present(registerVC, animated: true, completion: nil)
                
            }else{ // open Message List Screen
                let messageVC = storyBoard.instantiateViewController(withIdentifier: "MessageVC") as! MessageViewController
                
                messageVC.modalPresentationStyle = .fullScreen
                self.present(messageVC, animated: true, completion: nil)
            }
            
            print(successObject)
            
            self.view.makeToast("Success Call")
            
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


