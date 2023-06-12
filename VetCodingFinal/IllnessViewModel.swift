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
    
    func saveData(illness: IllnessModel, day: String) {
        if let id = illness.id {
            // Edit illness
            if !illness.title.isEmpty || !illness.code.isEmpty || illness.description.isEmpty {
                
                let docRef = db.collection("illness").document(id)
                docRef.updateData([
                    "title": illness.title,
                    "code": illness.code,
                    "description": illness.description
                ]) { [weak self] err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Illness updated!")
                        self?.addIllnessToDay(day: day, illnessId: id)
                    }
                }
            }
        } else {
            // Add illness
            if !illness.title.isEmpty || !illness.code.isEmpty || illness.description.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("illness").addDocument(data: [
                    "title": illness.title,
                    "code": illness.code,
                    "description": illness.description
                ]) { [weak self] err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Illness added with ID: \(ref!.documentID)")
                        self?.addIllnessToDay(day: day, illnessId: ref!.documentID)
                    }
                }
            }
        }
    }

    func addIllnessToDay(day: String, illnessId: String) {
        let docRefDay = db.collection("days").document(day)
        
        // Use FieldValue.arrayUnion() to add the illnessId to the array of references
        docRefDay.updateData([
            "illnesses": FieldValue.arrayUnion([illnessId])
        ]) { err in
            if let err = err {
                print("Error updating day document: \(err)")
            } else {
                print("Day updated with illness!")
            }
        }
    }


    
    
}
