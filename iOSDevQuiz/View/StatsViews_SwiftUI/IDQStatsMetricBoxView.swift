//
//  IDQStatsMetricBoxView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//

import SwiftUI

struct IDQStatsMetricBoxView: View {
    
    enum ResultValueType {
        case percentage
        case wholeNum
        case time
    }
    
    var title: String
    var value: Double
    var image: Image
    var resultValueType: ResultValueType
    
    private let titleFont = IDQConstants.setFont(fontSize: 18, isBold: false)
    private let valueFont = IDQConstants.setFont(fontSize: 40, isBold: true)
    private let textColor = IDQConstants.basicFontColor
    
    private var convertedValue: String {
        if resultValueType == .percentage {
            let myDouble = value * 100
            if myDouble.truncatingRemainder(dividingBy: 1) == 0 {
                return String(String((myDouble.rounded())).dropLast(2))//.appending("%")
            } else {
                return String(String((round(myDouble * 10) / 10)))//.appending("%")
            }
        } else if resultValueType == .wholeNum {
            return String(String(value.rounded()).dropLast(2))
        } else {
            let myDouble = ceil(value)
            return String(String(myDouble).dropLast(2))
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(convertedValue)
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
                .frame(width: 72, height: 72)
                .padding(.leading, 85)
                .padding(.top, 40)
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
