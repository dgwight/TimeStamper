//
//  Data.swift
//  ExcelDataExport
//
//  Created by Dylan Wight on 3/25/16.
//  Copyright © 2016 Dylan Wight. All rights reserved.
//

import Foundation

class Data {
    
    static let sharedInstance = Data()
    var lastPatientId: String?
    var timeStamps = [TimeStamp]()
    
    init() {}
    
    func addTimeStamp(timeStamp: TimeStamp) {
        self.lastPatientId = timeStamp.patientId
        timeStamps.append(timeStamp)
    }
    
    func clearTimestamps() {
        timeStamps.removeAll()
    }
    
    func getCount() -> Int {
        return timeStamps.count
    }
    
    func toTXT() -> String {
        var txt = "";
        for timeStamp in timeStamps {
            txt += String(timeStamp.patientId) + "`" + String(timeStamp.actionId) + "`" + String(timeStamp.timeStamp) + "`" + timeStamp.notes + " `⊗"
        }
        return txt
    }
    
    func loadFromTXT(txt: String) {
        let csvArray = txt.characters.split{$0 == "⊗"}.map(String.init)
        for timestamp in csvArray {
            let timestampTXTarray = timestamp.characters.split{$0 == "`"}.map(String.init)
            let patientId = timestampTXTarray[0]
            if let actionId = Int(timestampTXTarray[1]) {
                let timeStamp = timestampTXTarray[2]
                let notes = timestampTXTarray[3]
                self.addTimeStamp(TimeStamp(patientId: patientId, actionId: actionId, timeStamp: timeStamp, notes: notes))
            }
        }
    }
    
    func toCSV() -> String {
        var csv = "CaseID,ActionID,TimeStamp,Notes\n";
        for timeStamp in timeStamps {
            csv += String(timeStamp.patientId) + "," + String(timeStamp.actionId) + ",\"" + String(timeStamp.timeStamp) + "\",\"" + timeStamp.notes + "\"\n"
        }
        return csv
    }
    
    func getTimeStamps() -> [TimeStamp] {
        return self.timeStamps
    }
}
