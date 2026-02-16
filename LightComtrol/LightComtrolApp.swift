//
//  LightComtrolApp.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 14/02/2026.
//
import SwiftUI
import FirebaseCore

@main
struct LightComtrolApp: App {
    @StateObject private var auth = AuthManager()
    @StateObject private var bulbStore = BulbStore()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if auth.user != nil {
                OverviewPage()
                    .environmentObject(auth)
                    .environmentObject(bulbStore)
                    .onAppear { bulbStore.startListening() }
            } else {
                LoginPage()
                    .environmentObject(auth)
                    .onAppear { bulbStore.stopListening() }
            }
        }
    }
}


