//
//  MoodTableViewCell.swift
//  HRU_ClientExample
//
//  Created by lee on 20/12/2016.
//  Copyright © 2016 SwiftWithMe. All rights reserved.
//

import UIKit

//#2E94B9 UIColor(red:0.18, green:0.58, blue:0.73, alpha:1.0)
//#FFE869 UIColor(red:1.00, green:0.99, blue:0.76, alpha:1.0)
//#F0B775 UIColor(red:0.94, green:0.72, blue:0.46, alpha:1.0)
//#FD5959 UIColor(red:0.99, green:0.35, blue:0.35, alpha:1.0)


class MoodTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emotionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        backView.backgroundColor = MoodColor.random().color()
    }

}
