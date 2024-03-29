//
//  User + mocks.swift
//  HeadFlow
//
//  Created by Daria Andrioaie on 19.04.2023.
//

import Foundation

extension User {
    static let mockPatient1 = User(id: "1234", firstName: "Daria", lastName: "Andrioaie", email: "daria.andr@gmail.com", phoneNumber: "0767998715", profilePicture: URL(string: "https://img3.imonet.ro/XEDU/agent/622_200x200.jpg"), type: .patient)
    static let mockPatient2 = User(id: "1235", firstName: "Paul", lastName: "Adam", email: "paul.adam@gmail.com", phoneNumber: "0767998718", profilePicture: nil, type: .patient)
    static let mockTherapist1 = User(id: "1235", firstName: "Daniela", lastName: "Bucur", email: "daniela.bucur@gmail.com", phoneNumber: "0767998716", profilePicture: URL(string: "https://res.cloudinary.com/dlxu99ldy/image/upload/v1684178297/cld-sample.jpg"), type: .therapist)
}
