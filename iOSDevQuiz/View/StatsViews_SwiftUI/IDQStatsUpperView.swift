//
//  IDQStatsUpperView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import SwiftUI

struct IDQStatsUpperView: View {
    let lightOrange: Color = Color(IDQConstants.highlightedLightOrange)
    let darkOrange: Color = Color(IDQConstants.highlightedDarkOrange)
    let titleFont = IDQConstants.setFont(fontSize: 32, isBold: true)
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    darkOrange,
                    lightOrange
                ]),
                startPoint: .leading,
                endPoint: .topTrailing)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct IDQStatsUpperView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsUpperView()
    }
}
