//
//  SettingsView.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var auth: AuthManager

    var body: some View {
        VStack {
            Button("Log out", role: .destructive) {
                auth.signOut()
            }
        }
        .padding()
        .navigationTitle("Settings")
    }
}


#Preview {
    SettingsView()
}
