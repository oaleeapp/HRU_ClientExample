//
//  EmojiLoadingTableViewCell.swift
//  HRU_ClientExample
//
//  Created by lee on 20/12/2016.
//  Copyright © 2016 SwiftWithMe. All rights reserved.
//

import UIKit

class EmojiLoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var emojiLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundView?.alpha = 0.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
