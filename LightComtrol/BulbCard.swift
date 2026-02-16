//
//  BulbCard.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//

import SwiftUI

struct BulbCard: View {
    @Binding var bulb: Bulb

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: bulb.icon)
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                Text(bulb.name)
                    .font(.headline)
                Text(bulb.isOn ? "On" : "Off")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Toggle("", isOn: $bulb.isOn)
                .labelsHidden()
        }
        .padding()
        .background(.thinMaterial)        // nice “box” look
        .cornerRadius(14)
    }
}
#Preview {
    
}