//
//  ProfileModel.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 31/03/2023.
//

import Foundation

struct ProfileModel {
    var userModel: UserModel
    var email: String = ""
    var password: String = ""
    var newPassword: String = ""
    var confirmPassword: String = ""
    var errorMessage: String?
    var successMessage: String?
    var isShowingSuccessMessage = false
    var isShowingAlert = false
    var imageFileURL: URL?
    var isShowingScanner = false
    
    init(user: UserModel) {
        self.userModel = user
    }
}

