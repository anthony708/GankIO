//
//  ContentTableViewCell.swift
//  GankIO
//
//  Created by ZhuDuan on 16/1/27.
//  Copyright © 2016年 Anthony. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descLabel: UILabel!
    
    var labelURL = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
