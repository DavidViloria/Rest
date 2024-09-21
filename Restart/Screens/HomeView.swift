//
//  HomeView.swift
//  Restart
//
//  Created by David Viloria Ortega on 24/08/24.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingActive : Bool = false
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 30) {
            // MARK: - Header
            Spacer()
            ZStack {
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.09)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(Animation
                        .easeInOut(duration: 4)
                        .repeatForever(), value: isAnimating)
            }
            // MARK: - Center
            Text("The time that leads to mastery is dependent on the internsity of our focus")
                .font(.system(.title3, design: .rounded, weight: .light))
                .multilineTextAlignment(.center)
                .padding()
                .foregroundStyle(.secondary)
            // MARK: - Footer
            Spacer()
            Button {
                withAnimation {
                    isOnboardingActive = true
                }
            } label: {
                Image(systemName: "arrow.left.arrow.right.circle.fill")
                    .imageScale(.large)
                Text("Restart")
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            

        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                isAnimating = true
            })
        }
    }
}

#Preview {
    HomeView()
}
