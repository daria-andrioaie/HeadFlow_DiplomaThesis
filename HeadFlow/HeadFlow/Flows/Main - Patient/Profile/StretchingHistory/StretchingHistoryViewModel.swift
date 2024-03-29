//
//  StretchingHistoryViewModel.swift
//  HeadFlow
//
//  Created by Daria Andrioaie on 25.03.2023.
//

import Foundation

extension StretchingHistory {
    class ViewModel: ObservableObject {
        let patient: User
        let stretchingHistory: [StretchSummary.Model]
        let feedbackService: FeedbackServiceProtocol
        let onBack: () -> Void
        
        init(patient: User,
             stretchingHistory: [StretchSummary.Model],
             feedbackService: FeedbackServiceProtocol,
             onBack: @escaping () -> Void) {
            self.patient = patient
            self.stretchingHistory = stretchingHistory
            self.feedbackService = feedbackService
            self.onBack = onBack
        }
    }
}
