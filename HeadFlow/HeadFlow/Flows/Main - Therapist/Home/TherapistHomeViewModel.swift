//
//  TherapistHomeViewModel.swift
//  HeadFlow
//
//  Created by Daria Andrioaie on 18.04.2023.
//

import Foundation
import Combine

extension TherapistHome {
    class ViewModel: ObservableObject {
        @Published var selectedCollaborationStatus: CollaborationStatus = .active
        @Published var isLoading: Bool = true
        @Published var apiError: Error?
        @Published var collaborationsMap: [CollaborationStatus: [Collaboration]]
        
        let invitationPublisher = PassthroughSubject<Void, Never>()
        let therapistService: TherapistServiceProtocol
        let navigationAction: (TherapistHome.NavigationType) -> Void
        
        private var getCollaborationsListTask: Task<Void, Error>?
        private var cancellables = Set<AnyCancellable>()
        
        var collaborationsForSelectedStatus: [Collaboration] {
            collaborationsMap[selectedCollaborationStatus] ?? []
        }
        
        init(therapistService: TherapistServiceProtocol, navigationAction: @escaping (TherapistHome.NavigationType) -> Void) {
            self.therapistService = therapistService
            self.navigationAction = navigationAction
            
            collaborationsMap = Dictionary(uniqueKeysWithValues:
                                    CollaborationStatus.allCases.map { ($0, []) }
            )
        }
        
        private func configureCancellables() {
            // for some reason, this is not working
            invitationPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                self?.getCollaborationsList()
            }.store(in: &cancellables)
        }
        
        func getCollaborationsList() {
            getCollaborationsListTask?.cancel()
            isLoading = true
            getCollaborationsListTask = Task(priority: .userInitiated) { @MainActor in
                await therapistService.getAllPatientsForCurrentTherapist { [weak self] result in
                    switch result {
                    case .success(let collaborationsResponse):
                        DispatchQueue.main.async {
                            CollaborationStatus.allCases.forEach { collabStatus in
                                self?.collaborationsMap[collabStatus] = collaborationsResponse.filter { $0.status == collabStatus }
                            }
                            self?.isLoading = false
                        }
                        
                    case .failure(let error):
                        print(error.message)
                        DispatchQueue.main.async {
                            self?.apiError = Errors.CustomError(error.message)
                            self?.isLoading = false
                        }
                    }
                }
            }
        }
        
        deinit {
            getCollaborationsListTask?.cancel()
        }
    }
}
    
extension TherapistHome {
    enum NavigationType {
        case goToProfile
    }
}
