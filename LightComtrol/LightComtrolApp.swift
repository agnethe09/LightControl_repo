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
    
    var body: some Scene {
        WindowGroup {
            
            if isLoggedIn {
                ContentView()
            }
            else{
                LoginPage(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
