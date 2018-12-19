//
//  VideoCellTableViewCell.swift
//  PlayLocalVideo
//
//  Created by HalseyW-15 on 2018/12/19.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//

import UIKit

struct Video {
    let image: String
    let title: String
    let source: String
}

class VideoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
