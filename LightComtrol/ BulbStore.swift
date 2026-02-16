//
//   BulbStore.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//
import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class BulbStore: ObservableObject {
    @Published var bulbs: [Bulb] = []

    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    func startListening() {
        stopListening()

        guard let uid = Auth.auth().currentUser?.uid else {
            bulbs = []
            return
        }

        listener = db.collection("users")
            .document(uid)
            .collection("bulbs")
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    self.bulbs = []
                    return
                }

                self.bulbs = documents.map { doc in
                    let data = doc.data()
                    return Bulb(
                        id: doc.documentID,
                        name: data["name"] as? String ?? "",
                        icon: data["icon"] as? String ?? "lightbulb",
                        isOn: data["isOn"] as? Bool ?? false
                    )
                }
            }
    }

    func stopListening() {
        listener?.remove()
        listener = nil
    }

    
    
    func add(name: String, icon: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print("🟢 add() called. name=\(name), icon=\(icon)")


        db.collection("users")
            .document(uid)
            .collection("bulbs")
            .addDocument(data: [
                "name": name,
                "icon": icon,
                "isOn": false
            ])
    }

    func delete(_ bulb: Bulb) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        db.collection("users")
            .document(uid)
            .collection("bulbs")
            .document(bulb.id)
            .delete()
    }

    func setIsOn(_ bulb: Bulb, isOn: Bool) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        db.collection("users")
            .document(uid)
            .collection("bulbs")
            .document(bulb.id)
            .updateData(["isOn": isOn])
    }
}

