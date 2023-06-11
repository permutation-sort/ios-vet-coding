//
//  IllnessModel.swift
//  VetCoding
//
//  Created by Matt Koenig on 6/10/23.
//

import Foundation
import FirebaseFirestoreSwift

struct IllnessModel : Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var code: String
    var description: String
}
