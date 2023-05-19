//
//  IDQDonationResultView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 5/19/23.
//

import SwiftUI

struct IDQDonationResultView: View {
    var title: String
    var message: String
    var dismissAction: () -> Void
    
    private enum AnimationProperties {
        static let animationSpeed: Double = 4.0
        static let timerDuration: TimeInterval = 3.0
        static let blurRadius: CGFloat = 130
    }
    @State private var timer = Timer.publish(every: AnimationProperties.timerDuration, on: .main, in: .common).autoconnect()
    
    @ObservedObject private var animator = CircleAnimator(colors: GradientColors.all)
    
    var titleText: some View {
        Text(title)
            .font(Font(IDQConstants.setFont(fontSize: 40, isBold: true)))
    }
    
    var bodyText: some View {
        Text(message)
            .font(Font(IDQConstants.setFont(fontSize: 18, isBold: false)))
    }
    
    var body: some View {
        ZStack {
            ZStack {
                ForEach(animator.circles) { circle in
                    MovingCircle(originOffset: circle.position)
                        .foregroundColor(circle.color)
                }
            }
            .blur(radius: AnimationProperties.blurRadius)
            
            VStack {
                titleText
                    .foregroundColor(.white)
                    .blendMode(.difference)
                    .overlay(titleText.blendMode(.hue))
                    .overlay(titleText.foregroundColor(.black).blendMode(.overlay))
                bodyText
                    .foregroundColor(.white)
                    .blendMode(.difference)
                    .overlay(bodyText.blendMode(.hue))
                    .overlay(bodyText.foregroundColor(.black).blendMode(.overlay))
                Button("OK") {
                    dismissAction()
                }
                .padding()
            }
        }
        .background(GradientColors.backgroundColor)
        .onAppear {
            
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }
    private func animateCircle() {
        withAnimation(.easeIn(duration: AnimationProperties.animationSpeed)){
            animator.animate()
        }
    }
}

private enum GradientColors {
    static var all: [Color] {
        [
            Color(red: 12/255, green: 19/255, blue: 79/255),
            Color(red: 29/255, green: 38/255, blue: 125/255),
            Color(red: 92/255, green: 70/255, blue: 156/255),
            Color(red: 212/255, green: 173/255, blue: 252/255),
        ]
    }
    static var backgroundColor: Color {
        Color(uiColor: .black)
    }
}

private struct MovingCircle: Shape {
    var originOffset: CGPoint
    
    var animatableData: CGPoint.AnimatableData {
        get {
            originOffset.animatableData
        }
        set {
            originOffset.animatableData = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let adjustedX = rect.width * originOffset.x
        let adjustedY = rect.height * originOffset.y
        let smallestDimension = min(rect.width, rect.height)
        
        path.addArc(center: CGPoint(x: adjustedX, y: adjustedY), radius: smallestDimension/2, startAngle: .zero, endAngle: .degrees(360.0), clockwise: true)
        return path
    }
    
}

private class CircleAnimator: ObservableObject {
    
    class Circle: Identifiable {
        internal init(position: CGPoint, color: Color) {
            self.position = position
            self.color = color
        }
        let id = UUID()
        var position: CGPoint
        let color: Color
    }
    @Published private(set) var circles: [Circle] = []
    init(colors: [Color]) {
        circles = colors.map({ color in
            Circle(position: CircleAnimator.generateRandomPosition(), color: color)
        })
    }
    
    func animate() {
        objectWillChange.send()
        for circle in circles {
            circle.position = CircleAnimator.generateRandomPosition()
        }
    }
    
    static func generateRandomPosition() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
    }
    
}

struct IDQDonationResultView_Previews: PreviewProvider {
    static var previews: some View {
        IDQDonationResultView(title: "Thank you", message: "Thank you for supporting my work") {
            print(" ")
        }
    }
}
