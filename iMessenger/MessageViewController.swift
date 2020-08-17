//
//  MessageViewController.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 08/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate,  UITableViewDataSource {
    
    let App = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var newMessage: UILabel!
    @IBOutlet weak var iProfile: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var mLastLogin: UILabel!
    @IBOutlet weak var mWelcome: UILabel!
    
    var refreshControl = UIRefreshControl()
    
    
    // query date related
    var queryDate = Date()
    var dateComponent = DateComponents()
    var queryDateString: String?
    
    var messageList = [MessageDetail]()
    
    var newCount: Int32 = 0
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            print("Dragging")
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //scrollingFinished()
        print("Decelerating")
        
        for i in 0 ..< messageList.count{
            if(tableView.isCellVisible(section: 0, row: i)){
                if(messageList[i].MessageID != "0" && messageList[i].MsgStatus?.uppercased() == "NEW") {
                    
                    Router.sharedInstance().UpdateMessageStatus(messageId: messageList[i].MessageID! , success: { (successObject) in
                        
                        self.messageList[i].MsgStatus = "READ"
                        self.tableView.reloadData()
                        
                    }) { (failureObject) in
                        self.view.makeToast(failureObject)
                    }
                    
                }
            }
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        mLastLogin.text = "Last Login : " + getCurrentDateTimeString(formatString: "dd/MM/yyyy hh:mm a")
        
        titleView.layer.shadowColor = UIColor.systemGray.cgColor
        titleView.layer.shadowRadius = 2
        titleView.layer.shadowOpacity = 2
        titleView.layer.shadowOffset = CGSize(width:0, height: 3)
        titleView.layer.shadowPath = UIBezierPath(rect: titleView.bounds).cgPath
        
        iProfile.image = UIImage(named: "ic_profile")?.circleMask
        
        queryDateString = covertDateToString(date: queryDate, formatString: "yyyyMMdd")
        
        // load today messages
        loadMessagesByDate(dateString: queryDateString!)
        
        // load yesterday messages
        loadPreviousDayMessages()
        
        // pull to refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc
    func refresh(_ sender: AnyObject) {
        queryDate = Date()
        queryDateString = covertDateToString(date: queryDate, formatString: "yyyyMMdd")
        loadMessagesByDate(dateString: queryDateString!)
    }
    
    func loadPreviousDayMessages(){
        dateComponent.day = -1
        queryDate = Calendar.current.date(byAdding: dateComponent, to: queryDate)!
        queryDateString = covertDateToString(date: queryDate, formatString: "yyyyMMdd")
        
        loadMessagesByDate(dateString: queryDateString!)
    }
    
    
    func groupByDate(rawList: [MessageDetail])-> [MessageDetail]{
        
        var tmpList = [MessageDetail]()
        
        var dt1 = rawList[0].MsgDate?.components(separatedBy: " ")
        var dt2 = rawList[0].MsgDate?.components(separatedBy: " ")
        
        tmpList.append(MessageDetail(msgDate: dt1![0], msgStatus: "HEADER"))
        tmpList.append(rawList[0])
        
        for i in 1 ..< rawList.count{
            dt1 = rawList[i-1].MsgDate?.components(separatedBy: " ")
            dt2 = rawList[i].MsgDate?.components(separatedBy: " ")
            
            if(dt1![0].elementsEqual(dt2![0]) == false){
                tmpList.append( MessageDetail(msgDate: dt2![0], msgStatus: "HEADER"))
            }
            
            tmpList.append(rawList[i])
            
            if(tmpList[i].MsgStatus?.elementsEqual("NEW") == true){
                newCount += 1
            }
        }
        
        if(newCount==0){
            newMessage.text = "You have no new message"
        }else{
            newMessage.text = "You have \(newCount) new messages"
        }
        
        return tmpList
    }
    
    func loadMessagesByDate(dateString: String){
        Router.sharedInstance().GetUserMessagesByDate(mobileNo: App.MOBILE_NO, date: dateString, success: { (successObject) in
            self.view.makeToast("Updating user messages successful")
            
            
            self.messageList.append(contentsOf: self.groupByDate(rawList: successObject.MessageDetails!))
            
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
        }) { (failureObject) in
            self.view.makeToast(failureObject)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(HeaderTableCell.nib(), forCellReuseIdentifier: HeaderTableCell.indentifier)
        
        tableView.register(NoMessageTableCell.nib(), forCellReuseIdentifier: NoMessageTableCell.indentifier)
        
        tableView.register(MessageTableCell.nib(), forCellReuseIdentifier: MessageTableCell.indentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        
        // assign image button click
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(profileTapped(tapGestureReconizer:)))
        iProfile.isUserInteractionEnabled = true
        iProfile.addGestureRecognizer(tapGestureReconizer)
    }
    
    @objc
    func profileTapped(tapGestureReconizer: UITapGestureRecognizer){
        print("Image Clicked")
        
        let profileVC = self.storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileViewController
        
        profileVC.modalPresentationStyle = .fullScreen
        self.present(profileVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt index: IndexPath) -> UITableViewCell {
        
        print(index.row)
        
        if(index.row == messageList.count-1){
            print("load more ...")
            loadPreviousDayMessages()
        }
        
        if(messageList[index.row].MsgStatus == "HEADER"){
            let cellHeader = tableView.dequeueReusableCell(withIdentifier: HeaderTableCell.indentifier, for: index) as! HeaderTableCell
            
            cellHeader.configure(msgDate: messageList[index.row].MsgDate ?? "")
            
            return cellHeader
        }
        
        if(messageList[index.row].Messages == "No Messages"){
            let cellNoMessage = tableView.dequeueReusableCell(withIdentifier: NoMessageTableCell.indentifier, for: index) as! NoMessageTableCell
            
            cellNoMessage.configure(msg: messageList[index.row].Messages ?? "")
            
            return cellNoMessage
        }
        
        let cellItem = tableView.dequeueReusableCell(withIdentifier: MessageTableCell.indentifier, for: index) as! MessageTableCell
        
        //        cellItem.configure(message: messageList[index.row].Messages ?? "",
        //                           sender: messageList[index.row].Sender ?? "",
        //                           msgDate: messageList[index.row].MsgDate ?? "")
        //
        cellItem.configure(message: messageList[index.row].Messages ?? "",
                           sender: messageList[index.row].MsgStatus ?? "",
                           msgDate: messageList[index.row].MsgDate ?? "")
        
        if(messageList[index.row].MsgStatus?.uppercased() == "NEW"){
            cellItem.mMessage.font = UIFont.boldSystemFont(ofSize: 14.0)
        }else{
            cellItem.mMessage.font = UIFont.systemFont(ofSize: 14.0)
        }
        return cellItem
    }
}

extension UIImage {
    var circleMask: UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: .init(origin: .init(x: 0, y: 0), size: square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


extension UITableView {
    
    /// Check if cell at the specific section and row is visible
    /// - Parameters:
    /// - section: an Int reprenseting a UITableView section
    /// - row: and Int representing a UITableView row
    /// - Returns: True if cell at section and row is visible, False otherwise
    func isCellVisible(section:Int, row: Int) -> Bool {
        guard let indexes = self.indexPathsForVisibleRows else {
            return false
        }
        return indexes.contains {$0.section == section && $0.row == row }
    }  }
