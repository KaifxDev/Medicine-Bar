//
//  ForgotPassword.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 24/03/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .foregroundColor(.black)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.horizontal, 20)
                
                Button("Reset Password") {
                    // Implement password reset functionality
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 150, height: 50)
                .background(Color.orange)
                .cornerRadius(10)
                .padding(.top, 20)
            }
            .padding()
            .navigationBarTitle("Forgot Password", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                    .imageScale(.large)
            })
        }
    }
}



struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
