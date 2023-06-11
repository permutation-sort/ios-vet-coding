//  illnessDetail.swift
//  VetBillingApp
//
//  Created by Matt Koenig on 6/10/23.
//

import SwiftUI

struct illnessDetail: View {
    
    @Binding var illness : IllnessModel
    @StateObject var VetCodingApp = IllnessViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Illness title", text: $illness.title)
                .font(.headline)
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
            TextField("Illness code", text: $illness.code)
                .font(.subheadline)
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
            TextEditor(text: $illness.description)
                .font(.subheadline)
                .frame(height: 100)
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    VetCodingApp.saveData(illness: illness)
                    illness.title = ""
                    illness.code = ""
                    illness.description = ""
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct illnessDetail_Previews: PreviewProvider {
    static var previews: some View {
        illnessDetail(illness: .constant(IllnessModel(title: "one", code: "123456", description: "one illness")))
    }
}
