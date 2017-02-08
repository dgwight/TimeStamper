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
    
func loadDataFromFile(_ filename: String, data: Data) {
    if let tmpDir : NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first as NSString? {
        let path = tmpDir.appendingPathComponent(filename)
        do {
            let txtFromFile = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
            data.loadFromTXT(txtFromFile as String)
        } catch {
            print("\(error)")
        }
    }
}
