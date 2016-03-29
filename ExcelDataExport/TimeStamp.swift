//
//  TimeStamp.swift
//  ExcelDataExport
//
//  Created by Dylan Wight on 3/25/16.
//  Copyright © 2016 Dylan Wight. All rights reserved.
//

import UIKit

class TimeStamp {
    let caseId: UInt64
    let actionId: Int
    let timeStamp: String
    let notes: String
    
    init(caseId: UInt64, actionId: Int, timeStamp: String, notes: String) {
        self.caseId = caseId
        self.actionId = actionId
        self.timeStamp = timeStamp
        self.notes = notes
    }
}
