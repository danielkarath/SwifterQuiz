//
//  IDQStreakView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/16/23.
//

import SwiftUI

struct IDQStreakView: View {
    
    var value: Double
    
    private let viewModel = IDQStatsMetricBoxViewViewModel()
    private let titleFont = IDQConstants.setFont(fontSize: 13, isBold: false)
    private let valueFont = IDQConstants.setFont(fontSize: 15, isBold: true)
    private var streakImage: UIImage {
        if value > 0 {
            return IDQConstants.streakIcon
        } else {
            return IDQConstants.inactiveStreakIcon
        }
    }
    
    var body: some View {
        VStack {
            Image(uiImage: streakImage)
                .resizable()
                .frame(width: 75, height: 75)
                .scaledToFit()
                .padding(.bottom, -4)
            Text(String(viewModel.convertToString(value: value, type: .wholeNum)))
                .frame(width: 160, height: 20, alignment: .center)
                .font(Font(valueFont))
                .foregroundColor(Color(IDQConstants.basicFontColor))
                .kerning(1.10)
            Text("streak")
                .frame(width: 160, height: 16, alignment: .center)
                .font(Font(titleFont))
                .foregroundColor(Color(IDQConstants.secondaryFontColor))
                .padding(.top, -12)
        }
    }
}

struct IDQStreakView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStreakView(value: 0.0)
    }
}
