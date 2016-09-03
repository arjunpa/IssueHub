//
//  CommentLoadingTableViewCell.swift
//  IssueHub
//
//  Created by Arjun P A on 01/09/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit

class CommentLoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var loader:UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
