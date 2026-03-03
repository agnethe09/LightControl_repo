import SwiftUI

struct BulbView: View {
    @EnvironmentObject var bulbStore: BulbStore
    @State private var showingAddSheet = false

    @State private var showRenameAlert = false
    @State private var newName = ""
    @State private var bulbToRename: Bulb? = nil

    var body: some View {
        List {
            ForEach(bulbStore.bulbs) { bulb in
                HStack {
                    Image(systemName: bulb.icon)
                    Text(bulb.name)

                    Spacer()

                    Menu {
                        Button {
                            bulbToRename = bulb
                            newName = bulb.name
                            showRenameAlert = true
                        } label: {
                            Label("Rename", systemImage: "pencil")
                        }

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
                .environmentObject(bulbStore)
        }
        .alert("Rename Bulb", isPresented: $showRenameAlert) {
            TextField("New name", text: $newName)

            Button("Cancel", role: .cancel) {
                bulbToRename = nil
            }

            Button("Save") {
                if let bulbToRename {
                    bulbStore.renameBulb(bulbToRename, to: newName)
                }
                self.bulbToRename = nil
            }
        }
    }
}
