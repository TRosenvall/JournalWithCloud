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
    
    var title: String
    var body: String
    var timestamp: Date
    let recordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.recordID = recordID
    }
    
    convenience init?(record: CKRecord) {
        guard let title = record[EntryConstants.titleKey] as? String,
            let body = record[EntryConstants.bodyKey] as? String,
            let timestamp = record[EntryConstants.timestampKey] as? Date
            else {return nil}
        self.init(title: title, body: body, timestamp: timestamp, recordID: record.recordID)
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
