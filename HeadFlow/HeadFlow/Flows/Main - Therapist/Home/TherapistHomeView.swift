//
//  HomeView.swift
//  HeadFlow
//
//  Created by Daria Andrioaie on 18.04.2023.
//

import SwiftUI

struct TherapistHome {
    struct ContentView: View {
        @ObservedObject var viewModel: ViewModel

        var body: some View {
            VStack(spacing: 50) {
                TherapistHome.ListOfPatientsView(viewModel: viewModel)
                Buttons.ProfileButton(hasNotification: false) {
                    viewModel.navigationAction(.goToProfile)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .fillBackground()
        }
    }
}

struct TherapistHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(previewDevices) {
            TherapistHome.ContentView(
                viewModel: .init(therapistService: MockTherapistService(),
                                 navigationAction: { _ in }))
                .previewDevice($0)
                .previewDisplayName($0.rawValue)
        }
    }
}
