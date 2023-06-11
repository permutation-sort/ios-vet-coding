//
//  IllnessViewModel.swift
//  VetCoding
//
//  Created by Matt Koenig on 6/10/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class IllnessViewModel : ObservableObject {
    @Published var illnesses = [IllnessModel]()
    let db = Firestore.firestore()
    
    func fetchData() {
        self.illnesses.removeAll()
        db.collection("illness")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("error getting data")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.illnesses.append(try document.data(as: IllnessModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
                
            }
    }
    
    func saveData(illness: IllnessModel) {
        if let id = illness.id {
            // Edit note
            if !illness.title.isEmpty || !illness.code.isEmpty || illness.description.isEmpty {
                
                let docRef = db.collection("illness").document(id)
                docRef.updateData([
                    "title": illness.title,
                    "code": illness.code,
                    "description": illness.description
                ]) { err in
                    if let err = err {
                        print("error")
                    } else {
                        print("updated!")
                    }
                }
            }
        } else {
            // Add note
            if !illness.title.isEmpty || !illness.code.isEmpty || illness.description.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("illness").addDocument(data: [
                    "title": illness.title,
                    "code": illness.code,
                    "description": illness.description
                    ]) { err in
                        if let err = err {
                            print("error")
                        } else {
                            print("updated!")
                        }
                    }
            }


        }
    }
}
