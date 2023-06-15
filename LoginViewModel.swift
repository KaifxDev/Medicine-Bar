//
//  LoginViewModel.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 27/03/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    
    func validateInput() -> Bool {
        guard !username.isEmpty else {
            DispatchQueue.main.async {
                self.emailError = "Please enter your email address"
            }
            return false
        }
        guard isValidEmail(email: username) else {
            DispatchQueue.main.async {
                self.emailError = "Please enter a valid email address"
            }
            return false
        }
        guard !password.isEmpty else {
            DispatchQueue.main.async {
                self.passwordError = "Please enter your password"
            }
            return false
        }
        return true
    }

    
    func login(username: String, password: String) -> Bool {
        guard !username.isEmpty else {
            emailError = "Please enter your email address"
            return false
        }
        guard isValidEmail(email: username) else {
            emailError = "Please enter a valid email address"
            return false
        }
        guard !password.isEmpty else {
            passwordError = "Please enter your password"
            return false
        }
        return true
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
