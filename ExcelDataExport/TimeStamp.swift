//
//  TimeStamp.swift
//  ExcelDataExport
//
//  Created by Dylan Wight on 3/25/16.
//  Copyright © 2016 Dylan Wight. All rights reserved.
//

import UIKit

let actionNames = ["None", "Interview Complete", "In OR", "Anesthesia Ready", "Start Surgery", "Stop Surgery", "Extubate",  "Leave OR", "PACU Report Complete"]

class TimeStamp {
    let patientId: String
    let actionId: Int
    let timeStamp: String
    let notes: String
    
    init(patientId: String, actionId: Int, timeStamp: String, notes: String) {
        self.patientId = patientId
        self.actionId = actionId
        self.timeStamp = timeStamp
        self.notes = notes.stringByReplacingOccurrencesOfString("`", withString: "'").stringByReplacingOccurrencesOfString("⊗", withString: "x")
    }
}