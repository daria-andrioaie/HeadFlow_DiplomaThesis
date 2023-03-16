//
//  HomeView.swift
//  HeadFlow
//
//  Created by Daria Andrioaie on 25.02.2023.
//

import SwiftUI
import CoreMotion
import SceneKit

struct Home {    
    struct ContentView: View {
        @ObservedObject var viewModel: HomeViewModel
        @StateObject var notificationsViewModel = NotificationsViewModel()
        
        var body: some View {
            mainContent
            .customAlert(notificationsViewModel.notificationsAlert, isPresented: $notificationsViewModel.isNotificationsAlertPresented)
            .onAppear {
                notificationsViewModel.setupNotifications()
            }
            
        }
        
        var mainContent: some View {
            VStack(spacing: 50) {
                Button {
                    viewModel.navigationAction(.startStretchCoordinator)
                } label: {
                    VStack(alignment: .center, spacing: 20) {
                        Triangle(radius: 15)
                            .fill(Color.danubeBlue.opacity(0.8))
                            .frame(width: 80, height: 80)
                            .shadow(color: .gray.opacity(0.3), radius: 20, x: 5, y: 5)
                            .offset(x: 5)
                        Text("Start stretching")
                            .font(.Main.regular(size: 20))
                            .foregroundColor(.oceanBlue)
                    }
                    .frame(width: 140)
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                Button {
                    viewModel.navigationAction(.goToProfile)
                } label: {
                    Image(.userProfile)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35)
                        .padding(10)
                        .background(Color.diamond)
                        .clipShape(Circle())
//                        .shadow(color: .gray.opacity(0.3), radius: 20, x: 5, y: 5)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 40)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .fillBackground()

        }
    }
}



#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Home.ContentView(viewModel: HomeViewModel(navigationAction: { _ in }))
    }
}
#endif
