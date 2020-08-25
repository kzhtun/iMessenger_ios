//
//  RegisterViewController.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 05/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    let App = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var mRegister: UIButton!
    @IBOutlet weak var mName: UITextField!
    @IBOutlet weak var mMobile: UITextField!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        
        mRegister.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.522542417, blue: 0.1539843976, alpha: 1))
        mRegister.titleLabel?.textColor = UIColor.white
        mRegister.layer.cornerRadius = 20
        
        // set labels' color
        lblName.textColor = UIColor.red
        lblMobile.textColor = UIColor.red
        
        // hide labels
        lblName.isHidden = true
        lblMobile.isHidden = true
        
//        mName.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
//          mMobile.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
//        
//        mName.textColor = UIColor.init(cgColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
//         mMobile.textColor = UIColor.init(cgColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    @IBAction func RegisterOnClick(_ sender: UIButton) {
        //mName
        
        if(validateFields()){
            Router.sharedInstance().RegisterUser(userName: mName.text!, mobileNo: mMobile.text!, deviceId: getDeviceID(), success: { (successObject) in
                self.view.makeToast("Device is successfully register")
                
                self.validateUser()
                
                //                let messageVC = self.storyBoard.instantiateViewController(withIdentifier: "MessageVC") as! MessageViewController
                //
                //                messageVC.modalPresentationStyle = .fullScreen
                //                self.present(messageVC, animated: true, completion: nil)
                
            }) { (failureObject) in
                self.view.makeToast(failureObject)
            }
        }
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
    
    func validateFields()-> Bool{
        // hide labels
        lblName.isHidden = true
        lblMobile.isHidden = true
        
        if(mName.text == "") {
            lblName.text = "Name should not be left blank"
            lblName.isHidden = false
            
            print("name is empty")
            return false
        }
        
        if(mMobile.text == ""){
            lblMobile.text = "Mobile number should not be left blank"
            
            print("mobile number is empty")
            lblMobile.isHidden = false
            
            return false
        }
        
        return true;
    }
    
    
}



