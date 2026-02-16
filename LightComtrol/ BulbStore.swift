//
//   BulbStore.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//

import Foundation
import Combine

@MainActor
final class BulbStore: ObservableObject {
    @Published var bulbs: [Bulb] = []

    func add(name: String, icon: String) {
        bulbs.append(Bulb(name: name, icon: icon))
    }

    func delete(_ bulb: Bulb) {
        bulbs.removeAll { $0.id == bulb.id }
    }
}
