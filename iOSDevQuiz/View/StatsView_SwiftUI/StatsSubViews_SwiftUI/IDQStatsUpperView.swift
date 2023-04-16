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
            LinearGradient(
                gradient: Gradient(colors: [
                    darkerColor,
                    lighterColor
                ]),
                startPoint: .top,
                endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct IDQStatsUpperView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsUpperView()
    }
}
