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
            NavigationStack {
                HomeView()
                    .navigationTitle("Light Control")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack {
                BulbView()
                    .navigationTitle("Light Control")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Bulbs", systemImage: "lightbulb")
            }
            
            NavigationStack {
                SettingsView()
                    .navigationTitle("Light Control")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

#Preview {
    OverviewPage()
}
