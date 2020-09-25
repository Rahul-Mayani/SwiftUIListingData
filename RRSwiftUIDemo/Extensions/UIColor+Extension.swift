//
//  UIColor+Extension.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 24/09/20.
//

import Foundation
import UIKit

extension UIColor {
    
    class func blackColor() -> UIColor{
        return self.init(named: "BlackColor")!
    }
    
    class func darkBlackColor() -> UIColor{
        return self.init(named: "DarkBlackColor")!
    }
    
    class func blueColor() -> UIColor{
        return self.init(named: "BlueColor")!
    }
    
    class func whiteColor() -> UIColor{
        return self.init(named: "WhiteColor")!
    }
    
    class func redColor() -> UIColor{
        return self.init(named: "RedColor")!
    }
    
    class func clearColor() -> UIColor{
        return self.init(named: "ClearColor")!
    }
    
    class func lightBlackColor() -> UIColor{
        return self.init(named: "LightBlackColor")!
    }
}
