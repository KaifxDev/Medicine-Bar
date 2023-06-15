//
//  Homepage.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 20/03/2023.
//

import SwiftUI

struct WelcomePage: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @State private var isForgotPasswordViewPresented = false
    @State private var isRegistrationViewPresented = false

    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Image("WeBare")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.7)
                
                VStack(spacing: 20) {

                    Text("Medicine Bar")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 50)

                    VStack(alignment: .center, spacing: 20) {
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.black)
                                .padding(.leading)
                            
                            TextField("Username", text: $viewModel.username)
                                .padding()
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(10)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .foregroundColor(.black)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.trailing, 50)
                            
                        }
                        .padding(.horizontal, 20)
                        
                        PasswordField(password: $viewModel.password, passwordError: $viewModel.passwordError)
                        
                        Button(action: {
                            isForgotPasswordViewPresented = true
                        }) {
                            Text("Forgot your password?")
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isForgotPasswordViewPresented) {
                            ForgotPasswordView()
                        }
                        // Login button
                        NavigationLink(destination: HomePage()){
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 150, height: 50)
                                .background(Color.orange)
                                .cornerRadius(10)
                                .padding(.top, 5)
                        }
                        .onTapGesture {
                            guard viewModel.validateInput() else {
                                return
                            }
                            let loginSuccessful = viewModel.login(username: viewModel.username, password: viewModel.password)
                            if loginSuccessful {
                                ///
                            } else {
                                ///
                            }
                        }
                        .disabled(!viewModel.validateInput())
                        .opacity(viewModel.validateInput() ? 1 : 0.5)
                        .padding(.bottom, 20)
                        
                        Button(action: {
                            isRegistrationViewPresented = true
                        }) {
                            Text("Don't have an account? Sign up")
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isRegistrationViewPresented) {
                            RegistrationPage()
                        }
                        
                        
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 40)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    .navigationBarHidden(true)
                }
                .padding(.horizontal, 30)
            }
            .navigationBarHidden(true)
        }
        .accentColor(.white)
        .preferredColorScheme(.light)
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}

