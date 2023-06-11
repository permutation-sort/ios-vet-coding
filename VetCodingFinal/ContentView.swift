//  ContentView.swift
//  VetBillingApp
//
//  Created by Matt Koenig on 6/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var VetCoding = IllnessViewModel()
    @State var illness = IllnessModel(title: "", code: "", description: "")
    
    var body: some View {
        NavigationView {
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
            }
            .background(Color.white)
            .scrollContentBackground(.hidden)
            .onAppear {
                VetCoding.fetchData()
            }
            .refreshable {
                VetCoding.fetchData()
            }
            .padding(.horizontal)
            .navigationBarTitle("Vet Billing App", displayMode: .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
