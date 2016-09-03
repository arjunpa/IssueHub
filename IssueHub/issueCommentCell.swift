//
//  issueCommentCell.swift
//  IssueHub
//
//  Created by Arjun P A on 31/08/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit

class issueCommentCell: UITableViewCell {

    @IBOutlet weak var commentBody:UITextView!
    @IBOutlet weak var author:UILabel!
    @IBOutlet weak var date:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(comment:Comment){
        
        self.commentBody.text = comment.commentBody.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        self.author.text = comment.user.login
        self.date.text = DateHelper.makeDateStringWithFormat(DateHelper.DateHelperFormat.TZ, dateStr: comment.created_at)
    }
    
}
