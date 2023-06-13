//  AuthenticationView.swift
//  VetCodingFinal
//
//  Created by Matt Koenig on 6/12/23.
//
import SwiftUI

struct Authentication: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                if viewModel.loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                } else {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                        .padding(.bottom, 10)
                        .foregroundColor(.white)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                        .padding(.bottom, 10)
                        .foregroundColor(.white)

                    Button(action: {
                        viewModel.signUp(email: email, password: password)
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.green)
                            .cornerRadius(15.0)
                    }
                    .padding(.bottom, 10)

                    Button(action: {
                        viewModel.signIn(email: email, password: password)
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.orange)
                            .cornerRadius(15.0)
                    }
                }
            }
            .padding()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? "Unknown error"), dismissButton: .default(Text("OK")) {
                viewModel.showError = false
            })
        }
    }
}
