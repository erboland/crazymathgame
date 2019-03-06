//
//  TableViewCell.swift
//  Crazy Math Game
//
//  Created by Ербол Каршыга on 6/21/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet var labelResult: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
