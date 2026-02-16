//
//  HomeView.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var bulbStore: BulbStore

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach($bulbStore.bulbs) { $bulb in
                    HStack(spacing: 12) {
                        Image(systemName: bulb.icon)
                            .font(.title2)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(bulb.name).font(.headline)
                            Text(bulb.isOn ? "On" : "Off")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Toggle("", isOn: Binding(
                            get: { bulb.isOn },
                            set: { newValue in bulbStore.setIsOn(bulb, isOn: newValue) }
                        ))
                        .labelsHidden()
                    }
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(14)
                }
            }
            .padding()
        }
        .navigationTitle("Home")
    }
}
   
#Preview {
    HomeView()
}
