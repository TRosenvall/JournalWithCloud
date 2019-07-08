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
    
    
    
    // Update
    
    
    // Delete
    
}
