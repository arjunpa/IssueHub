//
//  DashboardViewController.swift
//  IssueHub
//
//  Created by Arjun P A on 30/08/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController {

    @IBOutlet weak var table_view:UITableView!
  //  var issueManager:IssueManager!
    var issues:[Issue] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTopLayoutGuide()
        self.doRegistrations()
        
        self.table_view.tableFooterView = UIView.init(frame: CGRectZero)
        
        // Do any additional setup after loading the view.
    }
    
    override func fetchData() {
        
        self.setupLoadingItem()
        let issueManager = IssueManager.init()
        
        issueManager.getIssues({ (issues) in
            
                self.setupRefreshItem()
                self.issues = issues
                self.table_view.reloadData()
            }) { (error) in
                
                self.setupRefreshItem()
                self.handleError(error)
        }
    }
    
    
    func setupLoadingItem(){
        
        let loadingItem = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        loadingItem.hidesWhenStopped = true
        loadingItem.startAnimating()
        loadingItem.color = UIColor.darkGrayColor()
        let rightBarItem = UIBarButtonItem.init(customView: loadingItem)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func setupRefreshItem(){
        
        let refreshItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: #selector(DashboardViewController.refreshClicked(_:)))
        self.navigationItem.rightBarButtonItem = refreshItem
    }
    
    
    func refreshClicked(sender:UIBarButtonItem){
        self.fetchData()
    }
    
    
    override func handleError(error: ErrorType?) {
        if let someError = error{
            
            let alertController = UIAlertController.init(title: "Unable to connect", message: "Please try again later", preferredStyle: .Alert)
            let okAction = UIAlertAction.init(title: "Retry", style: .Default, handler: { (action) in
            
                self.fetchData()
            })
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .Default, handler: { (action) in
            
               
            })
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }

    }
    
    
    
    func doRegistrations(){
        
        let nib = UINib.init(nibName: "IssueTableViewCell", bundle: nil)
        self.table_view.registerNib(nib, forCellReuseIdentifier: "IssueTableViewCell")
    }
    
    func setupTopLayoutGuide(){
      self.automaticallyAdjustsScrollViewInsets = false
      let topLayoutGuide = self.topLayoutGuide
      let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[topGuide]-[table_view]", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: ["topGuide":topLayoutGuide,"table_view":self.table_view])
      self.view.addConstraints(constraints)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension DashboardViewController:UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 90
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailVC:DetailViewController = DetailViewController.init(issue: issues[indexPath.item])
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension DashboardViewController:UITableViewDataSource{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return issues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.table_view.dequeueReusableCellWithIdentifier("IssueTableViewCell", forIndexPath: indexPath) as! IssueTableViewCell
        
        cell.configure(issues[indexPath.row])
        
        return cell
    }
}
