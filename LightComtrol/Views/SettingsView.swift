//
//  SettingsView.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var auth: AuthManager
    @StateObject private var esp = ESP32Client()
    
    var body: some View {
        VStack (spacing: 20){
            VStack{
                Text("ESP32 Relay")
                    .font(.title2)
                
                Text(esp.statusText)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(.thinMaterial)
            .cornerRadius(14)
            
            Button("Sign out", role: .destructive) {
                auth.signOut()
            }
            .padding()
            .background(.thinMaterial)
            .cornerRadius(14)
            
        }
        .navigationTitle("Settings")
        
        //        VStack(spacing: 16) {
        //                    Text("ESP32 Relay")
        //                        .font(.title2)
        //
        //                    Text(esp.statusText)
        //                        .font(.caption)
        //                        .multilineTextAlignment(.center)
        //
        //                    HStack(spacing: 12) {
        //                        Button("STATUS") { esp.refresh() }
        //                    }
        //                }
        //                .padding()
        //                .onAppear { esp.refresh() }
        //
        //    }
    }
}


#Preview {
    SettingsView()
}
