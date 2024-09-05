//
//  HomeView.swift
//  Restart
//
//  Created by David Viloria Ortega on 24/08/24.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingActive : Bool = false

    var body: some View {
        VStack(spacing: 30) {
            Text("Home")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.red)
            Button("Restart") {
                isOnboardingActive = true
            }
        }
    }
}

#Preview {
    HomeView()
}
