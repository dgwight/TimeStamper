//
//  FileAccess.swift
//  Patient Timestamper
//
//  Created by Dylan Wight on 3/30/16.
//  Copyright © 2016 Dylan Wight. All rights reserved.
//

import Foundation

let csvFileName = "PatientTimestamper.csv"
let txtFileName = "dataStore.txt"

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
    
func loadDataFromFile(filename: String, data: Data) {
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