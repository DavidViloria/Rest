//
//  OnboardingView.swift
//  Restart
//
//  Created by David Viloria Ortega on 24/08/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingActive : Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            VStack(spacing: 20) {
                // MARK: - Header
                Spacer()
                VStack(spacing: 0, content: {
                    Text("Share")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .fontWidth(.standard)
                        .foregroundStyle(.white)
                    
                    Text("""
                    It's not how much we give but how much love we put into giving
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                })
                // MARK: - Center
                //Circle Draggable
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.3)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                }
                
                Spacer()
                // MARK: - Footer
                ZStack(content: {
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .offset(x: 15)
                    
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(Color.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight:
                                        .heavy, design: .rounded))
                            
                        }
                        .foregroundStyle(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80{
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded({ _ in
                                    if buttonOffset > buttonWidth / 2{
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingActive = false
                                    }else{
                                        buttonOffset = 0
                                    }
                                })
                        )//: Gesture
                        Spacer()
                    }
                })
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()//: Footer
            }
        }//: Zstack
    }
}

#Preview {
    OnboardingView()
}
