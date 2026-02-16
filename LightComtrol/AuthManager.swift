//
//  AuthManager.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 16/02/2026.
//

import Foundation
import Combine
import FirebaseAuth

@MainActor
final class AuthManager: ObservableObject {
    @Published var user: User? = Auth.auth().currentUser
    @Published var errorMessage: String?

    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }

    func signIn(email: String, password: String) async {
        errorMessage = nil
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            user = result.user
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func signUp(email: String, password: String) async {
        errorMessage = nil
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            user = result.user
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func signOut() {
        errorMessage = nil
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}



//#Preview {
 //   AuthManager()
//}
