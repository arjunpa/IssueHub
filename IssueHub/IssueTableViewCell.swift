//
//  IssueTableViewCell.swift
//  IssueHub
//
//  Created by Arjun P A on 31/08/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    @IBOutlet weak var issueTitle:UILabel!
    @IBOutlet weak var issueBody:UITextView!
    let MAX_ALLOWED_CHARS:Int = 140
    override func awakeFromNib() {
        super.awakeFromNib()
        self.issueBody.textContainerInset = UIEdgeInsetsZero
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(issue:Issue){
        
        self.issueTitle.text = issue.issueTitle
        
        if issue.issueBody.characters.count > MAX_ALLOWED_CHARS{
            let index:String.Index = issue.issueBody.startIndex.advancedBy(MAX_ALLOWED_CHARS)
            let cutStr =  issue.issueBody.substringToIndex(index)
            self.issueBody.text = cutStr.stringByAppendingString("...")
        }
        else{
            self.issueBody.text = issue.issueBody
        }
    }
    
}
