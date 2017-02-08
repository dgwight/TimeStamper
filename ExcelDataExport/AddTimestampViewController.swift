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
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tick()
        patientIdInput.text = data.lastPatientId
        patientIdInput.clipsToBounds = true
        patientIdInput.layer.cornerRadius = notesInput.frame.size.height/20
        patientIdInput.layer.masksToBounds = false
        
        notesInput.layer.cornerRadius = notesInput.frame.size.height/20
        notesInput.layer.masksToBounds = true
        notesInput.layer.shadowOpacity=0.4

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,selector: #selector(AddTimestampViewController.tick), userInfo: nil, repeats: true)
    
        setUpListIcon()
    }
    
    func tick() {
        dateTime.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .short)
    }

    func segueToTableView() {
        performSegue(withIdentifier: "toTableView", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func displayTimestampEvents(_ sender: UIBarButtonItem) {
        if patientIdInput.text != "" {
            let actionSelector = UIAlertController(title: "Select Event", message: "For patient: " + patientIdInput.text!, preferredStyle: UIAlertControllerStyle.actionSheet)
            actionSelector.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            actionSelector.addAction(UIAlertAction(title: "Interview Complete", style: UIAlertActionStyle.default,
                handler: {(alert: UIAlertAction!) in self.addTimestamp(1)}))
            actionSelector.addAction(UIAlertAction(title: "In OR", style: UIAlertActionStyle.default,
                handler: {(alert: UIAlertAction!) in self.addTimestamp(2)}))
            actionSelector.addAction(UIAlertAction(title: "Anesthesia Ready", style: UIAlertActionStyle.default,
                handler: {(alert: UIAlertAction!) in self.addTimestamp(3)}))
            actionSelector.addAction(UIAlertAction(title: "Start Surgery", style: UIAlertActionStyle.default,
                handler: {(alert: UIAlertAction!) in self.addTimestamp(4)}))
            actionSelector.addAction(UIAlertAction(title: "Stop Surgery", style: UIAlertActionStyle.default,
                handler: {(alert: UIAlertAction!) in self.addTimestamp(5)}))
            actionSelector.addAction(UIAlertAction(title: "Extubate", style: UIAlertActionStyle.default,
                handler: {(alert: UIAlertAction!) in self.addTimestamp(6)}))
            actionSelector.addAction(UIAlertAction(title: "Leave OR", style: UIAlertActionStyle.default,
                handler: {(alert: UIAlertAction!) in self.addTimestamp(7)}))
            actionSelector.addAction(UIAlertAction(title: "PACU Report Complete", style: UIAlertActionStyle.default,
                handler: {(alert: UIAlertAction!) in self.addTimestamp(8)}))
            
            if let popoverController = actionSelector.popoverPresentationController {
                popoverController.barButtonItem = sender
            }
            self.present(actionSelector, animated: true, completion: nil)
        } else {
            let noIdError = UIAlertController(title: "Invalid Patient Id", message: "Please enter the patient's id", preferredStyle: UIAlertControllerStyle.alert)
            noIdError.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
  
            if let popoverController = noIdError.popoverPresentationController {
                popoverController.barButtonItem = sender
            }
            self.present(noIdError, animated: true, completion: nil)
        }
    }
    
    func addTimestamp(_ actionId: Int) {
        let patientId = patientIdInput.text!
        let timeStamp = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)
        let notes = notesInput.text ?? ""
        data.addTimeStamp(TimeStamp(patientId: patientId, actionId: actionId, timeStamp: timeStamp, notes: notes))
        notesInput.text = ""
        self.saveToFile(txtFileName, contents: data.toTXT())
        setUpListIcon()
    }
    
    func saveToFile(_ filename: String, contents: String) {
        if let tmpDir : NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first as NSString? {
            let path = tmpDir.appendingPathComponent(filename)
            let contentsOfFile = contents
            do {
                try contentsOfFile.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("\(error)")
            }
        }
    }
    
    func setUpListIcon() {
        let count = data.getCount()
        let viewTimestampsImage = UIImage(named: "ListIcon")
        let viewTimestampsButton = UIButton(type: UIButtonType.custom)
        viewTimestampsButton.frame = CGRect(x: 0.0, y: 0.0, width: viewTimestampsImage!.size.width, height: viewTimestampsImage!.size.height)
        viewTimestampsButton.setImage(viewTimestampsImage, for: UIControlState())
        viewTimestampsButton.setImage(UIImage(named: "ListIconH"), for: UIControlState.highlighted)
        
        if (count != 0) {
            let digits = Int(log10(Double(count)))
            let badge = UILabel(frame: CGRect(x: viewTimestampsButton.frame.size.width - 10.0, y: viewTimestampsButton.frame.origin.y - 4.0, width: 17.0 + CGFloat(digits * 6), height: 17.0))
            badge.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 91.0/255.0, blue: 84.0/255.0, alpha: 1.0)
            badge.layer.cornerRadius = 8.0
            badge.clipsToBounds = true
            badge.text = String(count);
            badge.textAlignment = NSTextAlignment.center
            badge.textColor = UIColor.white
            badge.font = UIFont(name: "Helvetica-Bold", size: 12.0)
        
            viewTimestampsButton.addSubview(badge)
        }
        viewTimestampsButton.addTarget(self, action: #selector(AddTimestampViewController.segueToTableView), for: UIControlEvents.touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTimestampsButton)
    }
}
