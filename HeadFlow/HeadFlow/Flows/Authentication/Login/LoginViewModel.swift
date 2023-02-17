//
//  LoginViewModel.swift
//  HeadFlow
//
//  Created by Daria Andrioaie on 12.02.2023.
//

import Foundation
import SwiftUI

extension Login {
    class ViewModel: ObservableObject {
        var onBack: () -> Void
        
        init(onBack: @escaping () -> Void) {
            self.onBack = onBack
        }
    }
}
