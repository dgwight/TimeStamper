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
    
    init() {
        if let csv = NSUserDefaults.standardUserDefaults().stringForKey("data") {
            fromCSV(csv)
        }
    }
    
    func addTimeStamp(timeStamp: TimeStamp) {
        timeStamps.append(timeStamp)
    }
    
    func fromCSV(csv: String) {
        let csvArray = csv.characters.split{$0 == ","}.map(String.init)
        for timestamp in csvArray {
            print(timestamp)
        }
    }
    
    func getCount() -> Int {
        return timeStamps.count
    }
    
    func saveData() {
        /*
        for timeStamp in timeStamps {
            timeStamp.toNSData()
        }
        NSUserDefaults.standardUserDefaults().setObject(data.toCSV(), forKey: "data")
 */
    }
    
    func toCSV() -> String {
        var csv = "CaseID,ActionID,TimeStamp,Notes\n";
        for timeStamp in timeStamps {
            csv += String(timeStamp.caseId) + "," + String(timeStamp.actionId) + ",\"" + String(timeStamp.timeStamp) + "\",\"" + timeStamp.notes + "\"\n"
        }
        return csv
    }
}
