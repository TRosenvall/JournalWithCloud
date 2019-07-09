//
//  CloudKitController.swift
//  JournalWithCloud
//
//  Created by Timothy Rosenvall on 7/8/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitController {
    // Singleton
    static let sharedInstance = CloudKitController()
    
    // Database Instance
    let database = CKContainer.default().publicCloudDatabase
    
    // Mark : - CRUD
    // Create
    func saveRecordToCloudKit(record: CKRecord, database: CKDatabase, completion: (Bool) -> Void) {
        database.save(record) { (record, error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
            } else if let record = record {
                print("Successfully saved: \(record)")}
        }
    }

    // Read
    func fetchRecordFromCloudKit(type: String, database: CKDatabase, completion: @escaping ([CKRecord]?, Error?)-> Void ) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: type, predicate: predicate)
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
                completion(nil, error)
            } else if let records = records {
                print("Fetched Records: \(records)")
                completion(records, nil)
            }
        }
    }

    // Update
    func updateRecordFromCloudKit(recordID: CKRecord.ID, database:
        CKDatabase, title: String, body: String, completion: @escaping (Bool) -> Void) {
 //       let operation = CKModifyRecordsOperation
 //       operation
        database.fetch(withRecordID: recordID) { (record, error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
            } else if let record = record {
                guard let entryToUpdate = Entry(record: record) else {return}
                entryToUpdate.title = title
                entryToUpdate.body = body
                entryToUpdate.timestamp = Date()
                let updatedRecord = CKRecord(entry: entryToUpdate)
                
                database.save(updatedRecord, completionHandler: { (record, error) in
                    if let error = error {
                        print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
                    } else if let record = record {
                        print("Successfully updated: \(record)")
                    }
                })
            }
        }
    }

    // Delete
    func deleteRecordFromCloudKit(recordID: CKRecord.ID, database: CKDatabase, completion: @escaping (Bool) -> Void) {
        database.delete(withRecordID: recordID) { (recordID, error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
            } else if let recordID = recordID {
                print("Successfully Deleted: \(recordID)")
            }
        }
    }
}

