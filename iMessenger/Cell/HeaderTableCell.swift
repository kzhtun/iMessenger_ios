//
//  HeaderTableCell.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 16/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import UIKit

class HeaderTableCell: UITableViewCell {
    static let indentifier = "HeaderTableCell"
    
    @IBOutlet weak var mHeaderDate: UILabel!
    
    static func nib()-> UINib{
           return UINib(nibName: "HeaderTableCell", bundle: nil)
       }
    
    public func configure( msgDate: String){
        mHeaderDate.text = msgDate
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
