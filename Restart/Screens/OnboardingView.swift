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
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share"
    
    let hapticFeedbak = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            VStack(spacing: 20) {
                // MARK: - Header
                Spacer()
                VStack(spacing: 0, content: {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .fontWidth(.standard)
                        .foregroundStyle(.white)
                        .transition(.opacity)
                        .id(textTitle
                        )
                    
                    Text("""
                    It's not how much we give but how much love we put into giving
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                })
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                // MARK: - Center
                //Circle Draggable
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.3)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 9))
                        .animation(.easeOut(duration: 0.5), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1: 0)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 16)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                })
                            
                                .onEnded({ _ in
                                    
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1.0
                                        textTitle = "Share."
                                    }
                                })
                        )//:Gesture
                        .animation(.easeOut(duration: 0.5), value: imageOffset)
                }
                .overlay(alignment: .bottom) {
                    Image(systemName: "arrow.left.arrow.right.circle")
                        .font(.system(size: 44))
                        .foregroundStyle(.white)
                        .offset(y: 15)
                        .opacity(isAnimating ? 1: 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
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
                            Image(systemName: "arrow.right.circle")
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
                                    withAnimation(Animation.easeInOut(duration: 1)) {
                                        if buttonOffset > buttonWidth / 2{
                                            hapticFeedbak.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: ".mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingActive = false
                                        }else{
                                            hapticFeedbak.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                })
                        )//: Gesture
                        Spacer()
                    }
                })
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()//: Footer
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1.2), value: isAnimating)
            }
        }//: Zstack
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    OnboardingView()
}
