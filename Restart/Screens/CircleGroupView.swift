//
//  CircleGroupView.swift
//  Restart
//
//  Created by David Viloria Ortega on 19/09/24.
//

import SwiftUI

struct CircleGroupView: View {
    @State var shapeColor: Color
    @State var shapeOpacity: Double
    @State private var isAnimating = false
    
    var body: some View {
        ZStack(content: {
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        })//: ZSTACK
        .blur(radius: isAnimating ? 1 : 0)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.4)
        .animation(.easeInOut(duration: 0.5), value: isAnimating)
        .onAppear() {
            isAnimating = true
        }
    }
}

#Preview {
    ZStack {
        Color(.blue)
            .ignoresSafeArea(.all, edges: .all)
        CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
    }
}
