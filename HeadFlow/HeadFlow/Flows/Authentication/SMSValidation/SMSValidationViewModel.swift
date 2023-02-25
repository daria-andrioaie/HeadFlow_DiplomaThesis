//
//  SMSValidationViewModel.swift
//  HeadFlow
//
//  Created by Daria Andrioaie on 20.02.2023.
//

import Foundation

extension SMSValidation {
    class ViewModel: ObservableObject {
        @Published var isLoading: Bool = false
        @Published var timeRemaining = 30
        @Published var inputCode: String = "" {
            didSet {
                if inputCode.count == 4 {
                    validateSMS()
                }
            }
        }
        
        let phoneNumber: String
        
        var navigationAction: ((SMSValidationNavigationType) -> Void)
        init(phoneNumber: String, navigationAction: @escaping (SMSValidationNavigationType) -> Void) {
            self.phoneNumber = phoneNumber
            self.navigationAction = navigationAction
        }
        
        func validateSMS() {
            //validate SMS
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.navigationAction(.onSMSValidated)
            }
            
        }
    }
    
    enum SMSValidationNavigationType {
        case goBack
        case onSMSValidated
    }
}
