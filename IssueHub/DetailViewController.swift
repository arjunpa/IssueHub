//
//  DetailViewController.swift
//  IssueHub
//
//  Created by Arjun P A on 31/08/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {

    @IBOutlet weak var table_view:UITableView!
    var issue:Issue!
    var comments:[Comment] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTopLayoutGuide()
        self.doRegistrations()
        self.loadCommentLoader()

        // Do any additional setup after loading the view.
    }
    
    func setupTopLayoutGuide(){
        self.automaticallyAdjustsScrollViewInsets = false
        let topLayoutGuide = self.topLayoutGuide
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[topGuide]-[table_view]", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: ["topGuide":topLayoutGuide,"table_view":self.table_view])
        self.view.addConstraints(constraints)
    }
    
    func loadCommentLoader(){
      
        var commentLoad:Comment = Comment()
        commentLoad.commentBody = ""
        commentLoad.created_at = ""
        commentLoad.updated_at = ""
        commentLoad.isLoadingModel = true
        self.comments.append(commentLoad)
    }
    
    func loadReloadCell(){
        
        var commentReload:Comment = Comment()
        commentReload.commentBody = ""
        commentReload.created_at = ""
        commentReload.updated_at = ""
        commentReload.isLoadingModel = false
        commentReload.isReloadCell = true
        self.comments.append(commentReload)
    }
    
    override func fetchData() {
        let commentsManager = CommentsManager.init()
        
        commentsManager.getComments(self.issue, success: { (comments:[Comment]) in
            
            self.comments = self.comments + comments
            
            let firstComment = self.comments[0]
            
            if firstComment.isLoadingModel{
                let indexPath = NSIndexPath.init(forRow: 0, inSection: 1)
                self.comments.removeFirst()
                self.table_view.beginUpdates()
                self.table_view.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                self.table_view.reloadSections(NSIndexSet.init(index: 1), withRowAnimation: .Automatic)
                self.table_view.endUpdates()
            }
            
            
         }) { (error) in
              self.handleError(error)
        }
    }

    override func handleError(error: ErrorType?) {
        if let someError = error{
            
            let alertController = UIAlertController.init(title: "Unable to connect", message: "Please try again later", preferredStyle: .Alert)
            let okAction = UIAlertAction.init(title: "Retry", style: .Default, handler: { (action) in
                
                self.comments = []
                self.loadCommentLoader()
                self.table_view.reloadSections(NSIndexSet.init(index: 1), withRowAnimation: .Automatic)
                self.fetchData()
            })
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .Default, handler: { (action) in
                
                self.comments = []
                self.loadReloadCell()
                self.table_view.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 1)], withRowAnimation: .Fade)
            })
        
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doRegistrations(){
        
       let classes = ["DetailIssueTableViewCell","issueCommentCell","CommentLoadingTableViewCell", "CommentReloadTableViewCell"]
        
        for class_name in classes{
            let nib = UINib.init(nibName: class_name, bundle: nil)
            self.table_view.registerNib(nib, forCellReuseIdentifier: class_name)
        }
    }
    
     init(issue:Issue) {

       super.init(nibName: "DetailViewController", bundle: nil)
       self.issue = issue

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController:UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            return 200
        }
        
        return 60
    }
}

extension DetailViewController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
          return 1
        }
        return comments.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            
            return "Issue"
        }
        
        if comments.count > 0{
            
            let firstComment = self.comments.first
            
            if !firstComment!.isLoadingModel && !firstComment!.isReloadCell{
                
                return "Comments" + "(" + "\(self.comments.count)" + ")"
            }
        }
        
        return "Comments"
    }
    
   
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
          let cell = self.table_view.dequeueReusableCellWithIdentifier("DetailIssueTableViewCell", forIndexPath: indexPath) as! DetailIssueTableViewCell
          
          cell.configure(issue)
            
          return cell
        }
        
        let comment = comments[indexPath.row]
        
        if comment.isLoadingModel{
            
                 let loadingCell = self.table_view.dequeueReusableCellWithIdentifier("CommentLoadingTableViewCell", forIndexPath: indexPath) as! CommentLoadingTableViewCell
                 loadingCell.loader.startAnimating()
                return loadingCell
        }
        else if comment.isReloadCell{
            let reloadCell = self.table_view.dequeueReusableCellWithIdentifier("CommentReloadTableViewCell", forIndexPath: indexPath) as! CommentReloadTableViewCell
            reloadCell.reloadBtn.addTarget(self, action: #selector(DetailViewController.reloadComment), forControlEvents: .TouchUpInside)
            return reloadCell
        }
        
        let cell = self.table_view.dequeueReusableCellWithIdentifier("issueCommentCell", forIndexPath: indexPath) as! issueCommentCell
        
        cell.configure(comment)
        
        return cell
    }
    
    func reloadComment(){
        self.comments = []
        self.loadCommentLoader()
        self.table_view.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 1)], withRowAnimation: .Fade)
        self.fetchData()
    }
}

