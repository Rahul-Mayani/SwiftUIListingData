//
//  RRSwiftUIDemoApp.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 24/09/20.
//

import SwiftUI

@main
struct RRSwiftUIDemoApp: App {
    
    @Environment(\.scenePhase) private var phase
    
    init() {
        RealmManager.migration()
    }
    
    var body: some Scene {
        WindowGroup {
            ListingView().environmentObject(RemovedDataPublisher())
        }
        .onChange(of: phase) { newPhase in
            switch newPhase {
            case .active: break
            // App became active
            case .inactive:break
            // App became inactive
            case .background:break
            // App is running in the background
            @unknown default:break
            // Fallback for future cases
            }
        }
    }
}
