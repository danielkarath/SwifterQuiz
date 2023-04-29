//
//  IDQStatsMetricBoxView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//

import SwiftUI

struct IDQStatsMetricBoxView: View {
    
    private let viewModel = IDQStatsMetricBoxViewViewModel()
    
    var title: String
    var value: Double
    var image: Image
    var resultValueType: IDQStatsMetricBoxViewViewModel.ResultValueType
    
    private let titleFont = IDQConstants.setFont(fontSize: 18, isBold: false)
    private let valueFont = IDQConstants.setFont(fontSize: 40, isBold: true)
    private let textColor = IDQConstants.basicFontColor
    
    var body: some View {
        ZStack {
            VStack {
                Text(viewModel.convertToString(value: value, type: resultValueType))
                    .frame(width: 160, height: 90, alignment: .center)
                    .font(Font(valueFont))
                    .foregroundColor(Color(textColor))
                    .kerning(2.35)
                Text(title)
                    .frame(width: 160, height: 28, alignment: .center)
                    .font(Font(titleFont))
                    .foregroundColor(Color(textColor))
                    .padding(.top, -35)
            }
        }
        .overlay(
            image
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.leading, 85)
                .padding(.top, 45)
                .aspectRatio(contentMode: .fit)
                .opacity(0.055)
        )
    }
}

struct IDQStatsMetricBoxView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsMetricBoxView(title: "monthly score", value: 18, image: Image(systemName: "graduationcap"), resultValueType: .wholeNum)
    }
}
