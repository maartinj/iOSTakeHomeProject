//
//  iOSTakeHomeProjectApp.swift
//  iOSTakeHomeProject
//
//  Created by Marcin Jędrzejak on 31/07/2022.
//

import SwiftUI

@main
struct iOSTakeHomeProjectApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleView()
                    .tabItem {
                        Symbols.person
                        Text("Home")
                    }
                SettingsView()
                    .tabItem {
                        Symbols.gear
                        Text("Settings")
                    }
            }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        #if DEBUG
        print("👷‍♂️ Is UI Test Running: \(UITestingHelper.isUITesting)")
        #endif
        
        return true
    }
}
