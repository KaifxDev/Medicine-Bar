//
//  Database.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 21/03/2023.
//

import Foundation
import Firebase
import FirebaseAuth

protocol DatabaseProtocol {
    func createUser(withEmail email: String, password: String, firstName: String, lastName: String, role: String, completion: @escaping (User?, Error?) -> Void)
    func addUser(_ user: User)
    func signIn(withEmail email: String, password: String, completion: @escaping (User?, Error?) -> Void)
}

class Database: DatabaseProtocol {
    func createUser(withEmail email: String, password: String, firstName: String, lastName: String, role: String, completion: @escaping (User?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(nil, error)
            } else if let user = result?.user {
                let newUser = User(uid: user.uid, email: user.email ?? "", firstName: firstName, lastName: lastName, password: password, role: role)
                completion(newUser, nil)
            } else {
                completion(nil, DatabaseError.createUserFailed)
            }
        }
    }
    
    func addUser(_ user: User) {
        let usersCollection = Firestore.firestore().collection("users")
        
        var userDocument = [String: Any]()
        userDocument["email"] = user.email
        userDocument["firstName"] = user.firstName
        userDocument["lastName"] = user.lastName
        userDocument["role"] = user.role
        
        usersCollection.document(user.uid ?? "").setData(userDocument) { error in
            if let error = error {
                print("Error adding user to database: \(error.localizedDescription)")
            } else {
                print("User added to database successfully")
            }
        }
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(nil, error)
            } else if let user = result?.user {
                let newUser = User(uid: user.uid, email: user.email ?? "", firstName: "", lastName: "", password: "", role: "")
                completion(newUser, nil)
            } else {
                completion(nil, DatabaseError.signInFailed)
            }
        }
    }
}

enum DatabaseError: Error {
    case createUserFailed
    case signInFailed
}
