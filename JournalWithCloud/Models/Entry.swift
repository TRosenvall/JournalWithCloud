//
//  Entry.swift
//  JournalWithCloud
//
//  Created by Timothy Rosenvall on 7/8/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation
import CloudKit

class Entry {
    
    let title: String
    let body: String
    let timestamp: Date
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: EntryConstants.typeKey)
        
        record.setValue(title, forKey: EntryConstants.titleKey)
        record.setValue(body, forKey: EntryConstants.bodyKey)
        record.setValue(timestamp, forKey: EntryConstants.timestampKey)
        
        return record
    }
    
    init(title: String, body: String, timestamp: Date) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
    
    init?(record: CKRecord) {
        guard let title = record[EntryConstants.titleKey] as? String,
            let body = record[EntryConstants.bodyKey] as? String,
            let timestamp = record[EntryConstants.timestampKey] as? Date
            else {return nil}
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.timestamp == rhs.timestamp
    }
}

struct EntryConstants {
    static let typeKey = "Entry"
    fileprivate static let titleKey = "Title"
    fileprivate static let bodyKey = "Body"
    fileprivate static let timestampKey = "Timestamp"
}
