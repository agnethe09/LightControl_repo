//
//  AddBulbView.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//
import SwiftUI

struct AddBulbView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var bulbStore: BulbStore

    @State private var name = ""
    @State private var selectedIcon = "lightbulb"

    private let icons = ["lightbulb", "lightbulb.fill", "lamp.table", "sun.max"]

    var body: some View {
        NavigationStack {
            Form {
                Section("Bulb Name") {
                    TextField("Enter name", text: $name)
                }

                Section("Choose Icon") {
                    Picker("Icon", selection: $selectedIcon) {
                        ForEach(icons, id: \.self) { icon in
                            Label(icon, systemImage: icon).tag(icon)
                        }
                    }
                }
            }
            .navigationTitle("Add Bulb")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        bulbStore.add(name: name, icon: selectedIcon)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
