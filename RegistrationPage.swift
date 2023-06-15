//
//  RegistrationPage.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 21/03/2023.
//

import SwiftUI

struct RegistrationPage: View {
    // Declare state variables to hold user input
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    let database = Database()
    @Environment(\.presentationMode) var presentationMode
    @State private var showForgotPassword = false
    @State private var showSignUp = false
    @State private var isEmailValid = true
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .keyboardType(.default)
                    
                    TextField("Last Name", text: $lastName)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .keyboardType(.asciiCapable)
                    
                    TextField("Email", text: $email, onEditingChanged: { _ in
                        isEmailValid = isValidEmail(email: email)
                    })
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(isEmailValid ? .black : .red)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isEmailValid ? Color.clear : Color.red, lineWidth: 1)
                    )
                    
                    if !isEmailValid {
                        Text("Please enter a valid email address")
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                }
                
                Section(header: Text("Account Information")) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .keyboardType(.asciiCapable)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .keyboardType(.asciiCapable)
                        .textContentType(.password)
                }
            }
            .navigationBarTitle(Text("Registration"), displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                    .imageScale(.large)
            }
                                ,trailing:
                                    Button(action: {
                submitRegistrationForm()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Submit")
                    .foregroundColor(.black)
            }
            )
            .sheet(isPresented: $showForgotPassword) {
                ForgotPasswordView()
            }
            .sheet(isPresented: $showSignUp) {
                WelcomePage()
            }
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
        }
    }
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func submitRegistrationForm() {
        let user = User(email: email, firstName: firstName, lastName: lastName, password: password, role: "Guest")
        database.createUser(withEmail: user.email, password: user.password, firstName: user.firstName, lastName: user.lastName, role: user.role) { (result, error) in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                return
            }
            
            guard let user = result else {
                print("Failed to get user")
                return
            }
            
            let newUser = User(uid: user.uid, email: user.email , firstName: user.firstName, lastName: user.lastName, password: user.password , role: user.role)
            database.addUser(newUser) // save the user to the database
            
            //let profileView = ProfileView(viewModel: .init(userModel: newUser.userModel))
            //let profileViewController = UIHostingController(rootView: profileView)
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    if let navigationController = window.rootViewController as? UINavigationController {
                        //navigationController.pushViewController(profileViewController, animated: true)
                    }
            }


        }
        
        presentationMode.wrappedValue.dismiss()
    }

}


struct RegistrationPage_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationPage()
    }
}
