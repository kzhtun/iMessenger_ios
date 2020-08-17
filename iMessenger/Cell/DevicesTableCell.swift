//
//  DevicesTableCell.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 17/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import UIKit

class DevicesTableCell: UITableViewCell {
   static let indentifier = "DevicesTableCell"
    
    @IBOutlet weak var mDelete: UIImageView!
    @IBOutlet weak var mSrNo: UILabel!
    @IBOutlet weak var mDeviceID: UILabel!
    static func nib()-> UINib{
            return UINib(nibName: "DevicesTableCell", bundle: nil)
        }
    
    public func configure(srNo: String, deviceId: String){
        mSrNo.text = srNo
        mDeviceID.text = deviceId
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
