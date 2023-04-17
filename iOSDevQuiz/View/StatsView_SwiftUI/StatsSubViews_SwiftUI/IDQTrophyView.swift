//
//  IDQTrophyView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/16/23.
//

import SwiftUI

struct IDQTrophyView: View {
    
    var value: Double
    
    private let viewModel = IDQStatsMetricBoxViewViewModel()
    private let titleFont = IDQConstants.setFont(fontSize: 16, isBold: false)
    private let valueFont = IDQConstants.setFont(fontSize: 18, isBold: true)
    private var trophyImage: UIImage {
        if value > 0 {
            return IDQConstants.trophyImage
        } else {
            return IDQConstants.inactiveTrophyImage
        }
    }
    
    var body: some View {
        VStack {
            Image(uiImage: trophyImage)
                .resizable()
                .frame(width: 110, height: 110)
                .scaledToFit()
                .padding(.bottom, 2)
            Text(String(viewModel.convertToString(value: value, type: .wholeNum)))
                .frame(width: 160, height: 24, alignment: .center)
                .font(Font(valueFont))
                .foregroundColor(Color(IDQConstants.basicFontColor))
                .kerning(1.20)
            Text("total score")
                .frame(width: 160, height: 20, alignment: .center)
                .font(Font(titleFont))
                .foregroundColor(Color(IDQConstants.secondaryFontColor))
                .padding(.top, -12)
        }
    }
}

struct IDQTrophyView_Previews: PreviewProvider {
    static var previews: some View {
        IDQTrophyView(value: 140.0)
    }
}
