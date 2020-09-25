//
//  RRDataModel.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 24/09/20.
//

import Foundation
import RealmSwift

class RRDataModel: Object {

    @objc dynamic var data: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var type: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RRDataModel {
    // save data into local DB
    class func create(from jsonResponse: [[String: Any]]) throws {
        do {
            // Delete all objects from the realm
            /*try RealmManager.shared.realm!.write {
                RealmManager.shared.realm!.deleteAll()
            }*/
            
            // Add new objects list in the realm
            RealmManager.shared.realm!.beginWrite()
            for json in jsonResponse {
                RealmManager.shared.realm!.create(RRDataModel.self, value: json, update: .modified)
            }
            try RealmManager.shared.realm!.commitWrite()
           
        } catch { throw error }
    }
    
    // sorting by data type (text, image & other)
    class func sortBy(_ sort: RRSortEnum) -> Results<RRDataModel>? {
        var data: Results<RRDataModel>? = nil
        // MARK: data sorting handling
        switch sort {
        case .all:
            data = RealmManager.shared.realm!.objects(RRDataModel.self)
        case .text:
            data = RealmManager.shared.realm!.objects(RRDataModel.self).filter("type contains 'text'")
        case .image:
            data = RealmManager.shared.realm!.objects(RRDataModel.self).filter("type contains 'image'")
        case .other:
            data = RealmManager.shared.realm!.objects(RRDataModel.self).filter("type contains 'other'")
        }
        return data
    }
    
    // removing single object data from local DB
    class func removeDataObject(_ data: RRDataModel) {
        // Delete all objects from the realm
        RealmManager.shared.realm!.beginWrite()
        RealmManager.shared.realm!.delete(data)
        try! RealmManager.shared.realm!.commitWrite()
    }
}
