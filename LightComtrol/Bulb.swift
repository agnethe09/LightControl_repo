//
//  Bulb.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//

import Foundation

struct Bulb: Identifiable {
    var id: String
    var name: String
    var icon: String
    var isOn: Bool = false
}
