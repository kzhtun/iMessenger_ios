//
//  MessageTableCell.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 12/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import UIKit

class MessageTableCell: UITableViewCell {
    
    static let indentifier = "MessageTableCell"
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var mProfile: UIImageView!
    @IBOutlet weak var mMessage: UILabel!
    
    @IBOutlet weak var mTime: UILabel!
    @IBOutlet weak var mSender: UILabel!
    
    static func nib()-> UINib{
        return UINib(nibName: "MessageTableCell", bundle: nil)
    }
    
    public func configure( message: String, sender: String, msgDate: String){
        mMessage.text = message
        mSender.text = sender
    
        // date
        let format = DateFormatter()
        format.dateFormat = "M/d/yyyy hh:mm:ss a"
        format.timeZone = .some(TimeZone(abbreviation: "UTC+08")!)

        let time = format.date(from: msgDate)
        format.dateFormat = "hh:mm a"

        mTime.text = format.string(from: time!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
           super.draw(rect)
           //Set containerView drop shadow
        
       containerView.layer.backgroundColor = UIColor.white.cgColor
             containerView.layer.cornerRadius = 10
               containerView.layer.borderWidth = 1.0
               containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
               containerView.layer.shadowRadius = 5.0
               containerView.layer.shadowOpacity = 10.0
               containerView.layer.shadowOffset = CGSize(width:2, height: 2)
               containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
         
       }
    
}

