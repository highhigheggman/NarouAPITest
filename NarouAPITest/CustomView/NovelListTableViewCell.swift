//
//  NovelListTableViewCell.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/11/03.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

import UIKit

class NovelListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var NovelTitle: UILabel!
    @IBOutlet weak var NovelAuthor: UILabel!
    @IBOutlet weak var NovelStory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
