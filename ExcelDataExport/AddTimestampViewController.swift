//
//  AddTimestampViewController.swift
//  Patient Timestamper
//
//  Created by Dylan Wight on 3/30/16.
//  Copyright © 2016 Dylan Wight. All rights reserved.
//

import UIKit

class AddTimestampViewController: UIViewController {
    
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var patientIdInput: UITextField!
    @IBOutlet weak var notesInput: UITextView!
    let data = Data.sharedInstance
    let now = NSDate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTime.text = NSDateFormatter.localizedStringFromDate(now, dateStyle: .LongStyle, timeStyle: .MediumStyle)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done(sender: UIBarButtonItem) {
        let actionSelector = UIAlertController(title: "Select Event", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        actionSelector.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        actionSelector.addAction(UIAlertAction(title: "Interview Complete", style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in self.addTimestamp(1)}))
        actionSelector.addAction(UIAlertAction(title: "In OR", style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in self.addTimestamp(2)}))
        actionSelector.addAction(UIAlertAction(title: "Anesthesia Ready", style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in self.addTimestamp(3)}))
        actionSelector.addAction(UIAlertAction(title: "Start Surgery", style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in self.addTimestamp(4)}))
        actionSelector.addAction(UIAlertAction(title: "Stop Surgery", style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in self.addTimestamp(5)}))
        actionSelector.addAction(UIAlertAction(title: "Extubate", style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in self.addTimestamp(6)}))
        actionSelector.addAction(UIAlertAction(title: "Leave OR", style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in self.addTimestamp(7)}))
        actionSelector.addAction(UIAlertAction(title: "PACU Report Complete", style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in self.addTimestamp(8)}))
        
        presentViewController(actionSelector, animated: true, completion: nil)
    }
    
    func addTimestamp(actionId: Int) {
        let patientId = patientIdInput.text!
        let timeStamp = NSDateFormatter.localizedStringFromDate(now, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        let notes = notesInput.text
        data.addTimeStamp(TimeStamp(patientId: patientId, actionId: actionId, timeStamp: timeStamp, notes: notes))
        notesInput.text = ""
        self.saveToFile(txtFileName, contents: data.toTXT())
        self.performSegueWithIdentifier("toTableView", sender: self)
    }
    
    func saveToFile(filename: String, contents: String) {
        if let tmpDir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = tmpDir.stringByAppendingPathComponent(filename)
            let contentsOfFile = contents
            do {
                try contentsOfFile.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
            } catch {
                print("\(error)")
            }
        }
    }
}
