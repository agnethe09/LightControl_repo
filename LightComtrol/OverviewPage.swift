//
//  OverviewPage.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//

import SwiftUI

struct OverviewPage: View {
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            BulbView()
                .tabItem {
                    Label("Bulbs", systemImage: "lightbulb")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        
    }
}

#Preview {
    OverviewPage()
}
