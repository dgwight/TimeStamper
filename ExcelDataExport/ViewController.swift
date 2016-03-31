//
//  ViewController.swift
//  ExcelExport
//
//  Created by Dylan Wight on 3/25/16.
//  Copyright © 2016 Dylan Wight. All rights reserved.
//

import UIKit
/*
class ViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    var docController = UIDocumentInteractionController()

    let data = Data.sharedInstance
    @IBOutlet weak var timestampCount: UILabel!
    @IBOutlet weak var notesInput: UITextView!
    @IBOutlet weak var patientIdInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadDataFromFile(txtFileName)
        timestampCount.text = String(data.getCount())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(sender: UIButton) {
        
        if let patientId = patientIdInput.text {
            let actionId = sender.tag
            let timeStamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)
            let notes = notesInput.text
            data.addTimeStamp(TimeStamp(patientId: patientId, actionId: actionId, timeStamp: timeStamp, notes: notes))
            notesInput.text = ""
            timestampCount.text = String(data.getCount())
            self.saveToFile(txtFileName, contents: data.toTXT())
        }

        //} else {
         //   invalidPatientId()
        //}
        //folderButton.badgeV
    }
    
    func invalidPatientId() {
        /*
        let alert = UIAlertController(title: "Invalid Patient Id", message: "Please enter valid Patient Id containing only numbers", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yo", style: UIAlertActionStyle.Destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yo", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yo", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yo", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yo", style: UIAlertActionStyle.Default, handler: nil))
        
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = self.view.bounds
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        */
        
        // display an alert

        
        
        
    
        let newWordPrompt = UIAlertController(title: "Enter definition", message: "Trainging the machine!", preferredStyle: UIAlertControllerStyle.Alert)
        newWordPrompt.addTextFieldWithConfigurationHandler(addTextField)
        newWordPrompt.addTextFieldWithConfigurationHandler(addTextField)

        newWordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: wordEntered))
        presentViewController(newWordPrompt, animated: true, completion: nil)
    }
    
    @IBAction func shareDoc(sender: UIBarButtonItem) {
        print("ShareDoc")
        self.saveToFile(csvFileName, contents: data.toCSV())
        if let tmpDir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = tmpDir.stringByAppendingPathComponent(csvFileName)
            docController = UIDocumentInteractionController(URL: NSURL(fileURLWithPath: path))
        }
        docController.UTI = "public.comma-separated-values-text"
        docController.delegate = self//delegate
        docController.name = "Export Data"
        docController.presentOptionsMenuFromBarButtonItem(sender, animated: true)
    }
    

    
    @IBOutlet var newWordField: UITextField?

    func wordEntered(alert: UIAlertAction!){
        // store the new word
        self.timestampCount.text = self.newWordField!.text
    }
    func addTextField(textField: UITextField!){
        // add the text field and make the result global
        textField.placeholder = "Definition"
        self.newWordField = textField
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
    
    func loadDataFromFile(filename: String) {
        if let tmpDir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = tmpDir.stringByAppendingPathComponent(filename)
            do {
                let txtFromFile = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                data.loadFromTXT(txtFromFile as String)
            } catch {
                print("\(error)")
            }
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
}

*/




