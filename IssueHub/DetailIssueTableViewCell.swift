//
//  DetailIssueTableViewCell.swift
//  IssueHub
//
//  Created by Arjun P A on 31/08/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit

class DetailIssueTableViewCell: UITableViewCell {

    @IBOutlet weak var issueTitle:UILabel!
    @IBOutlet weak var issueBody:UITextView!
    @IBOutlet weak var author:UILabel!
    @IBOutlet weak var dateTime:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(issue:Issue){
        
        self.issueTitle.text = issue.issueTitle
        self.issueBody.text = issue.issueBody.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        self.author.text = issue.user.login
        self.dateTime.text = DateHelper.makeDateStringWithFormat(DateHelper.DateHelperFormat.TZ, dateStr: issue.created_at)
    }
    
}
