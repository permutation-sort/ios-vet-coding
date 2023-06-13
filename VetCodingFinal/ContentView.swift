//  ContentView.swift
//  VetBillingApp
//
//  Created by Matt Koenig on 6/10/23.
//
import SwiftUI

struct ContentView: View {
    
    @StateObject var VetCoding = IllnessViewModel()
    @State var illness = IllnessModel(title: "", code: "", description: "")
    @EnvironmentObject var authViewModel: AuthViewModel

    // Add state for the selected day of the week
    @State private var selectedDay = "Monday"
    
    // Define the days of the week
    private let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Add a Picker for the days of the week
                    Picker("Select Day", selection: $selectedDay) {
                        ForEach(daysOfWeek, id: \.self) {
                            Text($0)
                        }
                    }
                    .onChange(of: selectedDay) { day in
                        VetCoding.fetchData(selection: day)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(15)
                    .padding()

                    ScrollView {
                        ForEach($VetCoding.illnesses) { $illness in
                            NavigationLink(destination: illnessDetail(illness: $illness)) {
                                Text(illness.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color.white.opacity(0.5))
                                    .cornerRadius(15)
                                    .padding(.horizontal)
                            }
                        }
                    }

                    NavigationLink(destination: illnessDetail(illness: $illness)) {
                        Text("New illness")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .navigationBarTitle("Vet Billing App", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Refresh", action: {
                    VetCoding.fetchData(selection: selectedDay)
                })
                .foregroundColor(.white)
                .padding()
                .background(Color.orange)
                .cornerRadius(15),
                trailing: Button("Sign Out", action: {
                    authViewModel.signOut()
                })
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(15))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
