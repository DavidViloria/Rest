//
//  OnboardingView.swift
//  Restart
//
//  Created by David Viloria Ortega on 24/08/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingActive : Bool = true

    
    var body: some View {
        VStack {
            Text("Onboarding")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color("AccentColor"))
                .multilineTextAlignment(.center)
            
            Button(action: {
                isOnboardingActive = false
            }, label: {
                Text("Start")
            })
        }
    }
}

#Preview {
    OnboardingView()
}
