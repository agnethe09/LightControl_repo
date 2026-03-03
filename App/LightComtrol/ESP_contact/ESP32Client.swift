//
//  ESP32Client.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 20/02/2026.
//

import Foundation
import Combine

final class ESP32Client: ObservableObject {
    @Published var statusText: String = "Unknown"
    
    // Put your ESP32 IP here
    var baseURL = "http:/192.168.1.129"
    
    func send(path: String) {
        guard let url = URL(string: baseURL + path) else { return }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.timeoutInterval = 3
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.statusText = "Error: \(error.localizedDescription)"
                    return
                }
                guard let data = data,
                      let text = String(data: data, encoding: .utf8) else {
                    self.statusText = "No response"
                    return
                }
                self.statusText = text
            }
        }.resume()
    }
    
    func turnOn() { send(path: "/on") }
    func turnOff() { send(path: "/off") }
    func refresh() { send(path: "/status") }
}
