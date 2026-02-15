//
//  LoginPage.swift
//  LightComtrol
//
//  Created by Agnethe Gajhede on 15/02/2026.
//

import SwiftUI

struct LoginPage: View {
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword: Bool = false
    
    var body: some View {
        VStack (spacing : 20){
            Text("Login")
                .font(Font.largeTitle)
                .bold()
            
            TextField ("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            HStack {
                if showPassword {
                    TextField("Password", text: $password)
                } else {
                    SecureField("Password", text: $password)
                }

                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)
            
            Button("Sign in"){
                isLoggedIn = true
            }
            .buttonStyle(.borderedProminent)
        }
        
    }
}

#Preview {
    LoginPage(isLoggedIn: .constant(false))
}
