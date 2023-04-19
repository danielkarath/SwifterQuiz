//
//  IDQSettingsViewCell.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/19/23.
//

import SwiftUI

struct IDQSettingsViewCell: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var cellTitle: String
    var subTitle: String
    var image: Image
    
    private let cellWidth: CGFloat = UIScreen.main.bounds.width - 64
    
    var body: some View {
        let imageOpacity: CGFloat = colorScheme == .light ? 0.037 : 0.22
        
        ZStack {
                image
                    .resizable()
                    .foregroundColor(Color(uiColor: IDQConstants.backgroundColor))
                    .frame(width: 85, height: 85)
                    .padding(.trailing, cellWidth * 0.96)
                    .padding(.top, 37)
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .opacity(imageOpacity)
            VStack {
                Text(cellTitle)
                    .frame(width: cellWidth, height: 23, alignment: .leading)
                    .font(Font(IDQConstants.setFont(fontSize: 20, isBold: true)))
                    .foregroundColor(Color(IDQConstants.basicFontColor))
                    .kerning(2.35)
                    .padding(.top, -4)
                Text(subTitle)
                    .frame(width: cellWidth, height: 15, alignment: .leading)
                    .font(Font(IDQConstants.setFont(fontSize: 13, isBold: true)))
                    .foregroundColor(Color(IDQConstants.secondaryFontColor))
                    .padding(.top, -6.5)
            }
            .padding(.leading, -32)
        }
    }
}

struct IDQSettingsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        IDQSettingsViewCell(cellTitle: "About", subTitle: "More stuff about the menu", image: Image(systemName: "person.fill"))
    }
}
