//
//  ContentView.swift
//  Restart
//
//  Created by David Viloria Ortega on 24/08/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingActive : Bool = true
    
    
    var body: some View {
        ZStack{
            if isOnboardingActive{
                OnboardingView()
            } else{
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
