//
//  IDQTargetView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/16/23.
//

import SwiftUI

struct IDQTargetView: View {
    
    var value: Double
    
    private let viewModel = IDQStatsMetricBoxViewViewModel()
    private let titleFont = IDQConstants.setFont(fontSize: 13, isBold: false)
    private let valueFont = IDQConstants.setFont(fontSize: 15, isBold: true)
    private var targetImage: UIImage {
        if value > 0 {
            return IDQConstants.targetImage
        } else {
            return IDQConstants.inactiveTargetIcon
        }
    }
    
    var body: some View {
        VStack {
            Image(uiImage: targetImage)
                .resizable()
                .frame(width: 75, height: 75)
                .scaledToFit()
                .padding(.bottom, -4)
            Text(String(viewModel.convertToString(value: value, type: .percentage)) + "%")
                .frame(width: 160, height: 20, alignment: .center)
                .font(Font(valueFont))
                .foregroundColor(Color(IDQConstants.basicFontColor))
                .kerning(1.10)
            Text("total accuracy")
                .frame(width: 160, height: 16, alignment: .center)
                .font(Font(titleFont))
                .foregroundColor(Color(IDQConstants.secondaryFontColor))
                .padding(.top, -12)
        }
    }
}

struct IDQTargetView_Previews: PreviewProvider {
    static var previews: some View {
        IDQTargetView(value: 89.4)
    }
}
