//
//  NoMessageTableCell.swift
//  iMessenger
//
//  Created by Kyaw Zin Htun on 17/08/2020.
//  Copyright © 2020 Kyaw Zin Htun. All rights reserved.
//

import UIKit

class NoMessageTableCell: UITableViewCell {
    
    static let indentifier = "NoMessageTableCell"
    
    @IBOutlet weak var mMessage: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    static func nib()-> UINib{
          return UINib(nibName: "NoMessageTableCell", bundle: nil)
      }
      
    public func configure( msg: String){
          mMessage.text = msg
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
