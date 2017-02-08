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
        self.timeStamps = timeStampsTemp.reversed()
        
        let trashIconImage = UIImage(named: "TrashIcon")
        let trashButton = UIButton(type: UIButtonType.custom)
        trashButton.frame = CGRect(x: 0.0, y: 0.0, width: trashIconImage!.size.width, height: trashIconImage!.size.height)
        trashButton.setImage(trashIconImage, for: UIControlState())
        trashButton.setImage(UIImage(named: "TrashIconH"), for: UIControlState.highlighted)
        trashButton.addTarget(self, action: #selector(TableViewController.clearClicked), for: UIControlEvents.touchUpInside)
        self.navigationController!.isToolbarHidden = false;
        self.setToolbarItems([UIBarButtonItem(customView: trashButton)], animated: true)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.getCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TimestampTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TimestampTableViewCell

        let timeStamp = timeStamps[indexPath.row]
        cell.patientId.text = timeStamp.patientId
        cell.action.text = actionNames[timeStamp.actionId]
        cell.date.text = timeStamp.timeStamp
        cell.notes.text = timeStamp.notes
        return cell
    }
    
    func clearClicked() {
        let confirmClear = UIAlertController(title: "Delete All Timestamps?", message: "Are you sure you want to delete all the timestamps saved? This can't be undone.", preferredStyle: UIAlertControllerStyle.alert)
        confirmClear.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        confirmClear.addAction(UIAlertAction(title: "Delete All", style: UIAlertActionStyle.destructive,
            handler: {(alert: UIAlertAction!) in self.clearTimestamps()}))
        
        present(confirmClear, animated: true, completion: nil)
    }
    
    func clearTimestamps() {
        data.clearTimestamps()
        saveToFile(txtFileName, contents: data.toTXT())
        loadView()
    }

    @IBAction func sharDoc(_ sender: UIBarButtonItem) {
        saveToFile(csvFileName, contents: data.toCSV())
        if let tmpDir : NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first as NSString? {
            let path = tmpDir.appendingPathComponent(csvFileName)
            docController = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
        }
        docController.uti = "public.comma-separated-values-text"
        docController.delegate = self//delegate
        docController.name = "Export Data"
        docController.presentOptionsMenu(from: sender, animated: true)
    }
    
    func segueToTableView() {
        performSegue(withIdentifier: "toAddTimestamp", sender: self)
    }

    override var shouldAutorotate : Bool {
        return false
    }
}
