//
//  IDQAboutTextView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/19/23.
//

import SwiftUI

struct IDQAboutTextView: View {
    
    var title: String
    var description: String
    
    var body: some View {
        let cellWidth: CGFloat = UIScreen.screenWidth < 1000 ? UIScreen.screenWidth * 0.95 : 720

        ZStack {
            Rectangle()
                .foregroundColor(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(16)
            VStack(spacing: -12) {
                HStack(spacing: 8) {
                    ZStack {
                        Rectangle()
                            .foregroundColor((Color(IDQConstants.backgroundColor.withAlphaComponent(0.10))))
                            .frame(width: 48, height: 48)
                            .cornerRadius(6)
                        Rectangle()
                            .foregroundColor(Color(IDQConstants.backgroundColor.withAlphaComponent(0.70)))
                            .frame(width: 42, height: 42)
                            .cornerRadius(6)
                        Image(systemName: "hand.wave")
                            .resizable()
                            .foregroundColor(Color(IDQConstants.basicFontColor))
                            .frame(width: 22, height: 22)
                    }
                    Text(title)
                        .frame(width: cellWidth - 96, height: 60, alignment: .leading)
                        .font(Font(IDQConstants.setFont(fontSize: 14, isBold: true)))
                        .foregroundColor(Color(IDQConstants.basicFontColor))
                        .padding(.top, 8)
                }
                .padding(.leading, 16)
                Text(description)
                    .frame(width: cellWidth - 68, height: 128, alignment: .leading)
                    .font(Font(IDQConstants.setFont(fontSize: 12, isBold: false)))
                    .foregroundColor(Color(IDQConstants.basicFontColor))
                    //.padding(.top, 8)
                Spacer()
            }
        }
    }
}

struct IDQAboutTextView_Previews: PreviewProvider {
    static var previews: some View {
        IDQAboutTextView(title: "About", description: "Hey, thank you for downloading my app!")
    }
}
