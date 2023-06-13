//
//  AuthenticationViewModel.swift
//  VetCodingFinal
//
//  Created by Matt Koenig on 6/12/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var loading = false
    @Published var signedIn = false
    @Published var error: Error?
    @Published var showError = false

    init() {
        signedIn = (Auth.auth().currentUser != nil)
    }


    func signUp(email: String, password: String) {
        self.loading = true
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            DispatchQueue.main.async {
                self.loading = false
                if let error = error {
                    self.error = error
                    self.showError = true
                } else {
                    self.signedIn = true
                }
            }
        }
    }

    func signIn(email: String, password: String) {
        self.loading = true
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            DispatchQueue.main.async {
                self.loading = false
                if let error = error {
                    self.error = error
                    self.showError = true
                } else {
                    self.signedIn = true
                }
            }
        }
    }

    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.signedIn = false
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            DispatchQueue.main.async {
                self.error = signOutError
                self.showError = true
            }
        }
    }
}

