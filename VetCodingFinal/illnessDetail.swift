//  illnessDetail.swift
//  VetBillingApp
//
//  Created by Matt Koenig on 6/10/23.
//
import SwiftUI

struct illnessDetail: View {
    
    @Binding var illness : IllnessModel
    @StateObject var VetCodingApp = IllnessViewModel()
    @State private var selectedDay = "Monday"
    @Environment(\.presentationMode) var presentationMode
    
    private let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    Picker("Select Day", selection: $selectedDay) {
                        ForEach(daysOfWeek, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(15)
                    .padding()

                    TextField("Illness title", text: $illness.title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                        .padding(.horizontal)

                    TextField("Illness code", text: $illness.code)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                        .padding(.horizontal)

                    TextEditor(text: $illness.description)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                        .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationBarTitle("Illness Detail", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("< Back")
                        .foregroundColor(.white)
                },
                trailing: Button(action: {
                    VetCodingApp.saveData(illness: illness, day: selectedDay)
                    illness.title = ""
                    illness.code = ""
                    illness.description = ""
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(15)
                }
            )
        }
    }
}

struct illnessDetail_Previews: PreviewProvider {
    static var previews: some View {
        illnessDetail(illness: .constant(IllnessModel(title: "one", code: "123456", description: "one illness")))
    }
}
