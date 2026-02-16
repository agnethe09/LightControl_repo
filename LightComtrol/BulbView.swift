//
//  BulbView.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//
import SwiftUI

struct BulbView: View {
    @EnvironmentObject var bulbStore: BulbStore
    @State private var showingAddSheet = false

    var body: some View {
        List {
            ForEach(bulbStore.bulbs) { bulb in
                HStack {
                    Image(systemName: bulb.icon)
                    Text(bulb.name)

                    Spacer()

                    Menu {
                        Button(role: .destructive) {
                            bulbStore.delete(bulb)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationTitle("My Bulbs")
        .toolbar {
            Button("Add Bulb") { showingAddSheet = true }
        }
        .sheet(isPresented: $showingAddSheet) {
            AddBulbView()
        }
    }
}
