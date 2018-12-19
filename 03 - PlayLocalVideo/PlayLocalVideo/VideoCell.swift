//
//  VideoCell.swift
//  PlayLocalVideo
//
//  Created by HalseyW-15 on 2018/12/19.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    @IBOutlet weak var ivVideoScreenShot: UIImageView!
    @IBOutlet weak var labelVideoTitle: UILabel!
    @IBOutlet weak var labelVideoSource: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
