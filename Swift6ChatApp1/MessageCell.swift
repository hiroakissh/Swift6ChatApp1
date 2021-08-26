//
//  MessageCell.swift
//  Swift6ChatApp1
//
//  Created by HiroakiSaito on 2021/08/26.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var LeftImageView: UIImageView!
    @IBOutlet weak var RightImageView: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        RightImageView.layer.cornerRadius = 25.0
        LeftImageView.layer.cornerRadius = 25.0
        backView.layer.cornerRadius = 10.0
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
