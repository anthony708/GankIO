//
//  CustomTableViewCell.swift
//  GankIO
//
//  Created by ZhuDuan on 16/1/19.
//  Copyright © 2016年 Anthony. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var beautyImageButton: UIButton!
    @IBOutlet weak var titleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
