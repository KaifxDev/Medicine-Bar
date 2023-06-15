//
//  ProfileView.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 30/03/2023.
//

import SwiftUI
import Combine
import FirebaseAuth // <-- Add this line
import FirebaseFirestore // <-- Add this line
import FirebaseStorage // <-- Add this line
import Foundation

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @StateObject var scanViewModel = ScanViewModel()
    
    func scannerView() -> some View {
        return ScanView(viewModel: scanViewModel) { image in
            viewModel.handleCapturedPhoto(image)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.model.userModel.firstName + " " + viewModel.model.userModel.lastName)
                        .font(.headline)
                    Text(viewModel.model.userModel.email)
                        .font(.subheadline)
                }
                .padding(.leading, 10)
                
                Spacer()
            }
            
            Divider()
            
            Text("Account Information")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 5) {
                if let middleName = viewModel.model.userModel.middleName {
                    Text("\(viewModel.model.userModel.firstName) \(middleName) \(viewModel.model.userModel.lastName)")
                } else {
                    Text("\(viewModel.model.userModel.firstName) \(viewModel.model.userModel.lastName)")
                }
                Text("Email: " + viewModel.model.userModel.email)
            }
            .padding(.bottom, 20)
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Change Email")
                    .font(.headline)
                
                TextField("New Email Address", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    viewModel.changeEmail()
                }) {
                    Text("Update Email")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .alert(isPresented: $viewModel.isShowingAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $viewModel.isShowingSuccessMessage) { // Use isShowingSuccessMessage instead of successMessage
                    Alert(title: Text("Success"), message: Text(viewModel.successMessage ?? ""), dismissButton: .default(Text("OK")))
                }
                
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Change Password")
                    .font(.headline)
                
                SecureField("Current Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("New Password", text: $viewModel.newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Confirm New Password", text: $viewModel.confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    viewModel.changePassword()
                }) {
                    Text("Update Password")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .alert(isPresented: $viewModel.isShowingAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $viewModel.isShowingSuccessMessage) { // Use isShowingSuccessMessage instead of successMessage
                    Alert(title: Text("Success"), message: Text(viewModel.successMessage ?? ""), dismissButton: .default(Text("OK")))
                }
                VStack(alignment: .leading, spacing: 10) {
                        Text("Scan University ID")
                            .font(.headline)
                        
                        if let fileURL = viewModel.imageFileURL,
                           let imageData = try? Data(contentsOf: fileURL),
                           let image = UIImage(data: imageData)
                        {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }
                        
                        Button(action: {
                            viewModel.isShowingScanner = true
                        }) {
                            Text("Scan ID")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        
                    }
                    .sheet(isPresented: $viewModel.isShowingScanner, content:  {
                        scannerView()
                    })
                    .onAppear {
                        //viewModel.loadProfile()
                    }
                    .alert(isPresented: $viewModel.isShowingAlert) {
                        Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                    }
                    
                }
            }
            
        }
    

    init() {
        let userModel = User(uid: "", email: "", firstName: "", lastName: "", password: "", role: "").userModel
        let viewModel = ProfileViewModel(model: ProfileModel(user: userModel))
        self.viewModel = viewModel
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}






