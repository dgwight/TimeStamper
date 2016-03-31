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
    
    var timeStamps = [TimeStamp]()
    
    init() {}
    
    func addTimeStamp(timeStamp: TimeStamp) {
        timeStamps.append(timeStamp)
    }
    
    func getCount() -> Int {
        return timeStamps.count
    }
    
    func toTXT() -> String {
        var txt = "";
        for timeStamp in timeStamps {
            txt += String(timeStamp.caseId) + "`" + String(timeStamp.actionId) + "`" + String(timeStamp.timeStamp) + "`" + timeStamp.notes + " `~"
        }
        return txt
    }
    
    func loadFromTXT(txt: String) {
        let csvArray = txt.characters.split{$0 == "~"}.map(String.init)
        for timestamp in csvArray {
            print(timestamp)
            let timestampTXTarray = timestamp.characters.split{$0 == "`"}.map(String.init)            
            if let caseId = UInt64(timestampTXTarray[0]) {
                if let actionId = Int(timestampTXTarray[1]) {
                    let timeStamp = timestampTXTarray[2]
                    //let notes = timestampTXTarray[3]
                    self.addTimeStamp(TimeStamp(caseId: caseId, actionId: actionId, timeStamp: timeStamp, notes: "test"))
                }
            }
        }
    }
    
    func toCSV() -> String {
        var csv = "CaseID,ActionID,TimeStamp,Notes\n";
        for timeStamp in timeStamps {
            csv += String(timeStamp.caseId) + "," + String(timeStamp.actionId) + ",\"" + String(timeStamp.timeStamp) + "\",\"" + timeStamp.notes + "\"\n"
        }
        return csv
    }
}
