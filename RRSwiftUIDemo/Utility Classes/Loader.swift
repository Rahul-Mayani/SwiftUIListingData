//
//  Loader.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 24/09/20.
//

import Foundation
import NVActivityIndicatorView
import UIKit

private let vLoader = UIView()

private let activityIndicatorView = NVActivityIndicatorView(frame: CGRect.init(0,0,50,50), type: .ballRotateChase, color: UIColor.blueColor(), padding: CGFloat(0))
//private let activityIndicatorView = UIActivityIndicatorView.init(style: .whiteLarge)

struct Loader {
    
    static func startAnimating(_ isMask: Bool = true)  {
        
        DispatchQueue.main.async {
            if isMask {
                vLoader.frame = UIScreen.main.bounds
                vLoader.backgroundColor = UIColor.blackColor().withAlphaComponent(0.2)
                appWindow?.addSubview(vLoader)
            }
            
            //activityIndicatorView.color = R.color.themeColor()
            //activityIndicatorView.hidesWhenStopped = true
            activityIndicatorView.center = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
            appWindow?.addSubview(activityIndicatorView)
            
            activityIndicatorView.startAnimating()
        }
    }
    
    static func stopAnimating() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            activityIndicatorView.stopAnimating()
            vLoader.removeFromSuperview()
        }
    }
}
