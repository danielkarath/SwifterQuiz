//
//  IDQStatsUpperView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import SwiftUI

struct IDQStatsUpperView: View {
    let lighterColor: Color = Color(IDQConstants.contentBackgroundColor)
    let darkerColor: Color = Color(IDQConstants.backgroundColor)
    let titleFont = IDQConstants.setFont(fontSize: 32, isBold: true)
    var body: some View {
        ZStack {
            CircleShape()
            .background(Color(IDQConstants.backgroundColor))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct IDQStatsUpperView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsUpperView()
    }
}

struct CircleShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.maxX, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 360), clockwise: true)
        }
    }
}
