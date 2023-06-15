//
//  ProfileViewModel.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 31/03/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore // <-- Add this line
import FirebaseStorage // <-- Add this line
import Foundation
import Firebase
import FirebaseDatabase

class CameraViewDelegateHandler: CameraViewDelegate {
    func cameraView(_ cameraView: CameraView, didCapturePhoto image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5),
              let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("capturedImage.jpg") else {
            return
        }
        do {
            try data.write(to: url)
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }
}

class ProfileViewModel: ObservableObject {
    @Published var model: ProfileModel
    @Published var userModel: UserModel
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var isShowingSuccessMessage = false
    @Published var isShowingAlert = false
    @Published var imageFileURL: URL?
    @Published var isShowingScanner = false
    @Published var profile: Profile?
    
    var cameraView: CameraView
    var cameraViewDelegateHandler: CameraViewDelegateHandler

    init(userModel: UserModel) {
            self.userModel = userModel
            self.model = ProfileModel(user: userModel)
            self.cameraViewDelegateHandler = CameraViewDelegateHandler()
        self.cameraView = CameraView(viewModel: ScanViewModel(), delegate: cameraViewDelegateHandler)
        }

    init(model: ProfileModel) {
            self.model = model
            self.userModel = model.userModel
            self.cameraViewDelegateHandler = CameraViewDelegateHandler()
        self.cameraView = CameraView(viewModel: ScanViewModel(), delegate: cameraViewDelegateHandler)
        }
    /*
    func loadProfile() {
        // Replace this with the actual code to fetch user data from the database
        // For now, I'm using dummy data
        self.profile = Profile(
            firstName: "John",
            lastName: "Doe",
            universityID: "12345678",
            scannedID: "98765432"
        )
    }*/
    
    func handleCapturedPhoto(_ image: UIImage) {
            // Save the image locally
            saveImageLocally(image: image)
        }
    
    private func saveImageLocally(image: UIImage) {
            // Save image to local storage
            if let data = image.jpegData(compressionQuality: 1.0) {
                let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let directory = urls[0]
                let filename = "universityID.jpg"
                let fileURL = directory.appendingPathComponent(filename)
                do {
                    try data.write(to: fileURL)
                    self.imageFileURL = fileURL
                } catch {
                    print("Error saving the image locally: \(error)")
                }
            }
        }
    
    func updateScannedID(scannedCode: String) {
            // Update the scanned ID in the user's profile and save it to the database
            // For now, we'll just update it in memory
            profile?.scannedID = scannedCode
        }
    
    func changeEmail() {
        if email.isEmpty {
            errorMessage = "Please enter your email address."
            isShowingAlert = true
            return
        }
        
        if !isValidEmail(email: email) {
            errorMessage = "Please enter a valid email address."
            isShowingAlert = true
            return
        }
        
        let currentUser = Auth.auth().currentUser
        let newEmail = email
        
        currentUser?.updateEmail(to: newEmail, completion: { (error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isShowingAlert = true
                return
            }
            
            // Email updated successfully
            self.successMessage = "Email address updated successfully."
            
            // Update the user object with the new email
            self.model.userModel.email = newEmail
            
            // Clear the email field
            self.email = ""
        })
    }


    func changePassword() {
        if password.isEmpty {
            errorMessage = "Please enter your current password."
            isShowingAlert = true
            return
        }
        
        if newPassword.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Please enter your new password."
            isShowingAlert = true
            return
        }
        
        if newPassword != confirmPassword {
            errorMessage = "Passwords do not match."
            isShowingAlert = true
            return
        }
        
        if newPassword == password {
            errorMessage = "New password cannot be the same as the current password."
            isShowingAlert = true
            return
        }
        
        let currentUser = Auth.auth().currentUser
        let newPassword = self.newPassword
        
        currentUser?.updatePassword(to: newPassword, completion: { (error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isShowingAlert = true
                return
            }
            
            // Password updated successfully
            self.successMessage = "Password updated successfully."
            
            // Clear the password fields
            self.password = ""
            self.newPassword = ""
            self.confirmPassword = ""
        })
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}


