//
//  ProfileViewController.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 17/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource  {
    
    let App = UIApplication.shared.delegate as! AppDelegate
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mMobile: UILabel!
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var iProfile: UIImageView!
    @IBOutlet weak var home: UIStackView!
    
    
    var profileList = [ProfileDetail]()
    
    override func viewDidAppear(_ animated: Bool) {
        loadProfileData()
    }
    
    func removeDevice(deviceId: String){
        Router.sharedInstance().UnRegisterDevice(deviceId: deviceId,  success: { (successObject) in
            
            if(deviceId.elementsEqual(getDeviceID())  == true){
                exit(-1)
            }else{
                self.loadProfileData()
            }
            
            
        }) { (failureObject) in
            self.view.makeToast(failureObject)
        }
    }
    
    func loadProfileData(){
        Router.sharedInstance().GetUserProfile(userHP: App.MOBILE_NO, success: { (successObject) in
            
            self.profileList = successObject.ProfileDetails!
            self.mName.text = self.profileList[0].ProfileName
            self.mMobile.text =  self.profileList[0].HPNo
            
            self.tableView.reloadData()
            
            
        }) { (failureObject) in
            self.view.makeToast(failureObject)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // assign image button click
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(homeTapped(tapGestureReconizer:)))
        home.isUserInteractionEnabled = true
        home.addGestureRecognizer(tapGestureReconizer)
        
        
        tableView.register(DevicesTableCell.nib(), forCellReuseIdentifier: DevicesTableCell.indentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @objc func homeTapped(tapGestureReconizer: UITapGestureRecognizer){
        
        let messageVC = self.storyBoard.instantiateViewController(withIdentifier: "MessageVC") as! MessageViewController
        
        messageVC.modalPresentationStyle = .fullScreen
        self.present(messageVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt index: IndexPath) -> UITableViewCell {
        
        let cellDeviceID = tableView.dequeueReusableCell(withIdentifier: DevicesTableCell.indentifier, for: index) as! DevicesTableCell
        
        cellDeviceID.configure(srNo: "\(index.row + 1)", deviceId: profileList[index.row].DeviceID!)
        
        
        cellDeviceID.tag = index.row
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteTapped(tapGestureRecognizer:)))
        cellDeviceID.mDelete.isUserInteractionEnabled = true
        
        cellDeviceID.addGestureRecognizer(tapGestureRecognizer)
        
        if((profileList[index.row].DeviceID?.elementsEqual(getDeviceID())) == true){
            cellDeviceID.mDeviceID.font = UIFont.boldSystemFont(ofSize: 11.0)
        }else{
            cellDeviceID.mDeviceID.font = UIFont.systemFont(ofSize: 11.0)
        }
        
        return cellDeviceID
    }
    
    @objc
    func deleteTapped(tapGestureRecognizer: UITapGestureRecognizer){
        
        let rootView = tapGestureRecognizer.view!
        
        if((profileList[rootView.tag].DeviceID?.elementsEqual(getDeviceID())) == true){
            showSimpleAlert(msg: "You about to remove current device from your list.Application will exit after removing.", deviceId: profileList[rootView.tag].DeviceID!)
            
        }else{
            showSimpleAlert(msg: "Are you sure want to remove this device from your list?", deviceId: profileList[rootView.tag].DeviceID!)
        }
        
        
    }
    
    
    func showSimpleAlert(msg: String, deviceId: String) {
        let alert = UIAlertController(title: "Device un-register?", message: msg,         preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        
                                        self.removeDevice(deviceId: deviceId)
                                        
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func unRegisterDevice(deviceId: String){
        Router.sharedInstance().UnRegisterDevice(deviceId: deviceId,  success: { (successObject) in
            self.view.makeToast("UnRegister Device successful")
            
            self.tableView.reloadData()
            
        }) { (failureObject) in
            self.view.makeToast(failureObject)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileList.count
    }
    
    
}
