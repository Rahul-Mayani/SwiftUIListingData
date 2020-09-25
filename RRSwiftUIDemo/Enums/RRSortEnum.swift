//
//  RRSortEnum.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 24/09/20.
//

import Foundation

enum RRSortEnum: Int {
    case all
    case text
    case image
    case other

    var title: String {
        switch self {
        case .all:
            return "All"
        case .text:
            return "Text"
        case .image:
            return "Image"
        case .other:
            return "Other"
        }
    }
}
