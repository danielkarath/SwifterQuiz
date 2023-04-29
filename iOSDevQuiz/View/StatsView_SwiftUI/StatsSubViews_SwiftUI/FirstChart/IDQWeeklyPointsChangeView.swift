//
//  IDQWeeklyPointsChangeView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/29/23.
//

import SwiftUI

struct IDQWeeklyPointsChangeView: View {
    var titleValue: Int
    var font: Font
    var fontColor: Color
    
    
    var body: some View {
        let imageName: String = titleValue < 1 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
        let size: CGFloat = 30
        
        HStack(spacing: -4) {
            Spacer()
            Text("\(titleValue)%")
                .frame(width: size*1.30, height: size, alignment: .center)
                .font(font)
                .foregroundColor(fontColor)
                .kerning(2.35)
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .offset(y: -size/10)
                .foregroundColor(Color(uiColor: IDQConstants.backgroundColor))
                .frame(width: size/1.60, height: size/1.60, alignment: .center)
        }
        .padding(.top, 16)
        .padding(.trailing, 8)
    }
}

struct IDQWeeklyPointsChangeView_Previews: PreviewProvider {
    static var previews: some View {
        IDQWeeklyPointsChangeView(titleValue: 6, font: Font(IDQConstants.setFont(fontSize: 16, isBold: true)), fontColor: Color(uiColor: IDQConstants.basicFontColor))
    }
}
