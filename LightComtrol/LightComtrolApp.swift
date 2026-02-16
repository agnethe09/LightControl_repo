//
//  LightComtrolApp.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 14/02/2026.
//

import SwiftUI

@main
struct LightComtrolApp: App {
    @State private var isLoggedIn:Bool = false
    @StateObject private var bulbStore = BulbStore()
    
    var body: some Scene {
        WindowGroup {
            
            if isLoggedIn {
                OverviewPage()
                    .environmentObject(bulbStore)
            }
            else{
                LoginPage(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
