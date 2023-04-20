//
//  Collaboration.swift
//  HeadFlow
//
//  Created by Daria Andrioaie on 20.04.2023.
//

import Foundation

enum CollaborationStatus: String {
    case pending, active
}

struct Collaboration {
    let patient: User
    let status: CollaborationStatus
}

extension Collaboration: Decodable {
    enum CodingKeys: String, CodingKey {
        case patient, status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patient = try container.decode(User.self, forKey: .patient)

        let statusAsString = try container.decode(String.self, forKey: .status)
        status = CollaborationStatus(rawValue: statusAsString) ?? .pending
    }
}

extension Collaboration: Hashable {
    static func == (lhs: Collaboration, rhs: Collaboration) -> Bool {
        return lhs.patient.id == rhs.patient.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(patient.id)
    }
}
