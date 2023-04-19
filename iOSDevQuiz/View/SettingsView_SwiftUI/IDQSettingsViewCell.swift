//
//  IDQSettingsViewCell.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/19/23.
//

import SwiftUI

struct IDQSettingsViewCell: View {
    
    var cellTitle: String
    var subTitle: String
    var image: Image
    
    private let cellWidth: CGFloat = UIScreen.main.bounds.width - 64
    
    var body: some View {
        
        ZStack {
            VStack {
                Text(cellTitle)
                    .frame(width: cellWidth, height: 23, alignment: .leading)
                    .font(Font(IDQConstants.setFont(fontSize: 20, isBold: true)))
                    .foregroundColor(Color(IDQConstants.basicFontColor))
                    .kerning(2.35)
                Text(subTitle)
                    .frame(width: cellWidth, height: 15, alignment: .leading)
                    .font(Font(IDQConstants.setFont(fontSize: 12, isBold: false)))
                    .foregroundColor(Color(IDQConstants.basicFontColor))
                    .padding(.top, -5)
            }
            .padding()
        }
        .overlay(
            image
                .resizable()
                .scaledToFit()
                .frame(width: 85, height: 85)
                .padding(.trailing, cellWidth * 0.96)
                .padding(.top, 45)
                .aspectRatio(contentMode: .fit)
                .opacity(0.06)
        )
        
    }
}

struct IDQSettingsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        IDQSettingsViewCell(cellTitle: "About", subTitle: "More stuff about the menu", image: Image(systemName: "person.fill"))
    }
}
