//
//  EntryController.swift
//  JournalWithCloud
//
//  Created by Timothy Rosenvall on 7/8/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation

class EntryController {
    // Singleton
    static let sharedInstance = EntryController()
    
    // Source Of Truth
    var entries: [Entry] = []
    
    // Mark : - CRUD
    // Create
    func createEntry (title: String, body: String) {
        let entry = Entry(title: title, body: body)
        let database = CloudKitController.sharedInstance.database
        CloudKitController.sharedInstance.saveRecordToCloudKit(recordID: entry.recordID, database: database) { (success) in
            if success {
                print("Entry Created")
            }
        }
        self.entries.append(entry)
    }
    
    // Read
    func fetchEntries () {
        let database = CloudKitController.sharedInstance.database
        CloudKitController.sharedInstance.fetchRecordFromCloudKit(type: EntryConstants.typeKey, database: database) { (records, error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
            } else if let records = records {
                let entries = records.compactMap( {Entry(record: $0)} )
                self.entries = entries
            }
        }
    }
    
    
    // Update
    func updateEntry (entry: Entry, title: String, body: String) {
        let database = CloudKitController.sharedInstance.database
        entry.title = title
        entry.body = body
        entry.timestamp = Date()
        CloudKitController.sharedInstance.updateRecordFromCloudKit(recordID: entry.recordID, database: database, title: title, body: body) { (success) in
            if success {
                print("Successfully update entry")
            }
        }
    }
    
    
    // Delete
    func deleteEntry (entry: Entry) {
        let database = CloudKitController.sharedInstance.database
        CloudKitController.sharedInstance.deleteRecordFromCloudKit(recordID: entry.recordID, database: database) { (success) in
            print("Successfully deleted entry")
        }
        guard let entryIndex = entries.firstIndex(of: entry) else {return}
        entries.remove(at: entryIndex)
    }
}
