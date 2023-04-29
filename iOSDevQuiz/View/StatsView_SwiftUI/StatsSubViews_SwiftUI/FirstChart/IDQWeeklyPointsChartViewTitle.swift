//
//  IDQWeeklyPointsChartViewTitle.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/29/23.
//

import SwiftUI

struct IDQWeeklyPointsChartViewTitle: View {
    
    var title: String
    var font: Font
    var fontColor: Color
    
    var body: some View {
        HStack {
            Text(title)
                .frame(width: 160, height: 21, alignment: .leading)
                .font(font)
                .foregroundColor(fontColor)
                .kerning(2.35)
                .padding(.top, 16)
                .padding(.leading, 8)
            //Spacer()
        }
    }
}

struct IDQWeeklyPointsChartViewTitle_Previews: PreviewProvider {
    static var previews: some View {
        IDQWeeklyPointsChartViewTitle(title: "Weekly Points", font: Font(IDQConstants.setFont(fontSize: 14, isBold: false)), fontColor: Color(uiColor: IDQConstants.basicFontColor))
    }
}
