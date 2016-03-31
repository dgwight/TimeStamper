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
        patientIdInput.text = data.lastPatientId
        
        
        notesInput.layer.cornerRadius = notesInput.frame.size.height/20
        notesInput.layer.masksToBounds = true
        notesInput.layer.shadowOpacity=0.4
        
        
        //let shadowView = UIView(frame: notesInput.frame)
        //shadowView.layer.shadowOffset = CGSizeMake(1, 1)
        //shadowView.layer.shouldRasterize = true
        //shadowView.layer.masksToBounds = false
        //notesInput.addSubview(shadowView)


        patientIdInput.clipsToBounds = true
        patientIdInput.layer.cornerRadius = notesInput.frame.size.height/20
        //patientIdInput.layer.shadowOpacity=0.4
        //patientIdInput.layer.shadowOffset = CGSizeMake(1, 1)
        //patientIdInput.layer.shouldRasterize = true
        patientIdInput.layer.masksToBounds = false

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done(sender: UIBarButtonItem) {
        if patientIdInput.text != "" {
            let actionSelector = UIAlertController(title: "Select Event", message: "For patient: " + patientIdInput.text!, preferredStyle: UIAlertControllerStyle.ActionSheet)
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
            
            if let popoverController = actionSelector.popoverPresentationController {
                popoverController.barButtonItem = sender
            }
            self.presentViewController(actionSelector, animated: true, completion: nil)
        } else {
            let noIdError = UIAlertController(title: "Invalid Patient Id", message: "Please enter the patient's id", preferredStyle: UIAlertControllerStyle.Alert)
            noIdError.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
  
            if let popoverController = noIdError.popoverPresentationController {
                popoverController.barButtonItem = sender
            }
            self.presentViewController(noIdError, animated: true, completion: nil)
        }
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
