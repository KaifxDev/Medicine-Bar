//
//  User.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 21/03/2023.
//

import Foundation

// This struct represents a user in the application
struct User {
    var uid: String?
    var email: String
    var firstName: String
    var lastName: String
    var password: String
    var role: String
    var middleName: String?
    
    var userModel: UserModel {
        .init(email: email, firstName: firstName, lastName: lastName)
    }
    
    init(uid: String? = nil, email: String, firstName: String, lastName: String, password: String, role: String, middleName: String? = nil) {
        self.uid = uid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.role = role
        self.middleName = middleName
    }
}






