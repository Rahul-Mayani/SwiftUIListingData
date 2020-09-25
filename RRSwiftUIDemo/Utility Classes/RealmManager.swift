//
//  RealmManager.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 24/09/20.
//

import Foundation
import RealmSwift

public struct RealmManager {
    
    static let shared = RealmManager()
    
    var realm = try? Realm()
}

// MARK: - Realm -
extension RealmManager {
    
    static func migration() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
         
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // the magic happens here: `id` is the property you specified
                    // as your primary key on your Model
                    var nextID = 1
                    migration.enumerateObjects(ofType: RRDataModel.className()) { oldObject, newObject in
                        newObject!["id"] = "\(nextID)"
                        nextID += 1
                    }
                }
            })
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
}
