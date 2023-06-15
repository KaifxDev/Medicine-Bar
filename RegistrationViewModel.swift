//
//  RegistrationViewModel.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 30/03/2023.
//

import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var name: String = ""
    @Published var errorMessage: String?
    
    func validateInput() -> Bool {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address."
            return false
        }
        guard isValidEmail(email: email) else {
            errorMessage = "Please enter a valid email address."
            return false
        }
        guard !password.isEmpty else {
            errorMessage = "Please enter your password."
            return false
        }
        guard !confirmPassword.isEmpty else {
            errorMessage = "Please confirm your password."
            return false
        }
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
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
