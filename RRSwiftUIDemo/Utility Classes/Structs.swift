//
//  Structs.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 24/09/20.
//

import Foundation
import UIKit

var appWindow: UIWindow? {
    guard let scene = UIApplication.shared.connectedScenes.first,
            let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
            let window = windowSceneDelegate.window else {
        return nil
    }
    return window
}

public struct APIEndPoint {
    
    static let endPointURL = Environment.production.rawValue
    
    private enum Environment:String {
        case develop = "local host"
        case staging = "stage"
        case production = "https://raw.githubusercontent.com/"
    }
    
    struct Name {
        static let axxessTech = endPointURL + "AxxessTech/Mobile-Projects/master/challenge.json"
    }
}

public struct ViewTitle {
    
    struct Name {
        static let listingVC = "Data Listing"
        static let detailsVC = "Details"
    }
}

