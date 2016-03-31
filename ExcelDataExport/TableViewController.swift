//
//  TableViewController.swift
//  Patient Timestamper
//
//  Created by Dylan Wight on 3/30/16.
//  Copyright © 2016 Dylan Wight. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIDocumentInteractionControllerDelegate {
    let data = Data.sharedInstance
    var timeStamps = [TimeStamp]()
    var docController = UIDocumentInteractionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timeStampsTemp = data.getTimeStamps()
        self.timeStamps = timeStampsTemp.reverse()
        let clearButton = UIBarButtonItem(title: "Clear", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TableViewController.clearClicked))
        //self.navigationController!.toolbar.setItems([clearButton], animated: true)
        self.navigationController!.toolbarHidden = false;
        
        self.setToolbarItems([clearButton], animated: true)

    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.getCount()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TimestampTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TimestampTableViewCell

        let timeStamp = timeStamps[indexPath.row]
        cell.patientId.text = timeStamp.patientId
        cell.action.text = actionNames[timeStamp.actionId]
        cell.date.text = timeStamp.timeStamp
        cell.notes.text = timeStamp.notes
        return cell
    }
    
    func clearClicked() {
        let confirmClear = UIAlertController(title: "Delete All Timestamps?", message: "Are you sure you want to delete all the timestamps saved in the app? This can't be undone.", preferredStyle: UIAlertControllerStyle.Alert)
        confirmClear.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        confirmClear.addAction(UIAlertAction(title: "Delete All", style: UIAlertActionStyle.Destructive,
            handler: {(alert: UIAlertAction!) in self.clearTimestamps()}))
        
        presentViewController(confirmClear, animated: true, completion: nil)
    }
    
    func clearTimestamps() {
        data.clearTimestamps()
        loadView()
    }

    @IBAction func shareDoc(sender: UIBarButtonItem) {
        print("ShareDoc")
        saveToFile(csvFileName, contents: data.toCSV())
        if let tmpDir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = tmpDir.stringByAppendingPathComponent(csvFileName)
            docController = UIDocumentInteractionController(URL: NSURL(fileURLWithPath: path))
        }
        docController.UTI = "public.comma-separated-values-text"
        docController.delegate = self//delegate
        docController.name = "Export Data"
        docController.presentOptionsMenuFromBarButtonItem(sender, animated: true)
    }

    override func shouldAutorotate() -> Bool {
        return false
    }
}