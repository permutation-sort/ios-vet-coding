//  ContentView.swift
//  VetBillingApp
//
//  Created by Matt Koenig on 6/10/23.
//

// todo!
// make it so that each day of week has a list of items from that day
// update the code to be a dropdown of exsiting options 

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
                .padding()
                
                List {
                    ForEach($VetCoding.illnesses) { $illness in
                        NavigationLink(destination: illnessDetail(illness: $illness)) {
                            Text(illness.title)
                                .font(.headline)
                                .padding(.vertical)
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                }
                Section {
                    NavigationLink(destination: illnessDetail(illness: $illness)) {
                        Text("New illness")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 15))
                            .padding(.vertical)
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                }
                .background(Color.white)
                .scrollContentBackground(.hidden)
                .onAppear {
                    VetCoding.fetchData(selection: selectedDay)
                }
                .refreshable {
                    VetCoding.fetchData(selection: selectedDay)
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Vet Billing App", displayMode: .large)
            .navigationBarItems(trailing: Button("Sign Out", action: {
                authViewModel.signOut()
            }))

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
