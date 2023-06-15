//
//  PasswordField.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 23/03/2023.
//

import SwiftUI

struct PasswordField: View {
    @Binding var password: String
    @Binding var passwordError: String
    @State private var isPasswordVisible = false
    
    init(password: Binding<String>, passwordError: Binding<String>) {
        self._password = password
        self._passwordError = passwordError
    }
    
    var body: some View {
        HStack {
            Image(systemName: "key.fill")
                .foregroundColor(.black)
                .padding(.leading)
            
            if isPasswordVisible {
                TextField("Password", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .keyboardType(.asciiCapable)
                    .textContentType(.password)
                    .foregroundColor(Color.black)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
            } else {
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .keyboardType(.asciiCapable)
                    .textContentType(.password)
                    .foregroundColor(Color.black)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
            }
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.black)
            }
            .padding(.trailing, 20)
        }
        .padding(.horizontal, 20)
        
        if !passwordError.isEmpty {
            Text(passwordError)
                .foregroundColor(.red)
        }
    }
}

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordField(password: .constant(""), passwordError: .constant(""))
    }
}
