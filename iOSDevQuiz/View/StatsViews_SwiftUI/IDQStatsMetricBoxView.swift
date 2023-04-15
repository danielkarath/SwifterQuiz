//
//  IDQStatsMetricBoxView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//

import SwiftUI

struct IDQStatsMetricBoxView: View {
    
    var title: String
    var value: Double
    var image: Image
    var isPercentage: Bool
    
    private let titleFont = IDQConstants.setFont(fontSize: 14, isBold: false)
    private let valueFont = IDQConstants.setFont(fontSize: 35, isBold: true)
    private let textColor = IDQConstants.basicFontColor
    
    private var convertedValue: String {
        if isPercentage {
            return String(String(value.rounded() * 100).dropLast(2))//.appending("%")
        } else {
            return String(String(value.rounded()).dropLast(2))
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(convertedValue)
                    .frame(width: 125, height: 64, alignment: .center)
                    .font(Font(valueFont))
                    .foregroundColor(Color(textColor))
                    .kerning(2.35)
                Text(title)
                    .frame(width: 140, height: 28, alignment: .center)
                    .font(Font(titleFont))
                    .foregroundColor(Color(textColor))
                    .padding(.top, -30)
            }
        }
        .overlay(
            image
                .resizable()
                .frame(width: 72, height: 72)
                .padding(.leading, 72)
                .padding(.top, 40)
                .aspectRatio(contentMode: .fit)
                .opacity(0.06)
        )
    }
}

struct IDQStatsMetricBoxView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsMetricBoxView(title: "monthly score", value: 18, image: Image(systemName: "graduationcap"), isPercentage: false)
    }
}
