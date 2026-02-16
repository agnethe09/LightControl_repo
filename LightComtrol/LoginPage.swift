//
//  LoginPage.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//

import SwiftUI

struct LoginPage: View {
    @EnvironmentObject var auth: AuthManager

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 14) {

            Text("Please log in to continue")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)

            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            if let msg = auth.errorMessage {
                Text(msg)
                    .foregroundStyle(.red)
                    .font(.footnote)
                    .padding(.horizontal)
            }

            Button("Sign In") {
                Task {
                    await auth.signIn(
                        email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                        password: password
                    )
                }
            }
            .buttonStyle(.borderedProminent)

            Button("Create Account") {
                Task {
                    await auth.signUp(
                        email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                        password: password
                    )
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
