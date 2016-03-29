//
//  ViewController.swift
//  ExcelExport
//
//  Created by Dylan Wight on 3/25/16.
//  Copyright © 2016 Dylan Wight. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    var docController = UIDocumentInteractionController()
    
    let data = Data.sharedInstance
    @IBOutlet weak var timestampCount: UILabel!
    @IBOutlet weak var patientId: UITextField!
    @IBOutlet weak var notesInput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timestampCount.text = "0";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(sender: UIButton) {
        
        if let caseId = UInt64(patientId.text!) {
            let actionId = sender.tag
            let timeStamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)
            let notes = notesInput.text
            
            data.addTimeStamp(TimeStamp(caseId: caseId, actionId: actionId, timeStamp: timeStamp, notes: notes))
            print("time: " + timeStamp)
            
            notesInput.text = ""
            
            timestampCount.text = String(data.getCount())
        } else {
            invalidPatientId()
        }
    }
    
    func invalidPatientId() {
        let alert = UIAlertController(title: "Invalid Patient Id", message: "Please enter valid Patient Id containing only numbers", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func shareDoc(sender: UIBarButtonItem) {
        let fileName = "PatientTimestamper.csv"
        if let tmpDir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = tmpDir.stringByAppendingPathComponent(fileName)
            let contentsOfFile = data.toCSV()
            
            do {
                try contentsOfFile.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
                docController = UIDocumentInteractionController(URL: NSURL(fileURLWithPath: path))
            } catch {
                print("\(error)")
            }
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



