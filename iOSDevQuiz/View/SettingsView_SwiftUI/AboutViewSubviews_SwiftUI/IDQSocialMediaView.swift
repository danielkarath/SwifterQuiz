//
//  IDQSocialMediaView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/19/23.
//

import SwiftUI

struct IDQSocialMediaView: View {
    
    
    var title: String
    var subTitle: String
    var image: Image
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(10)
            VStack(spacing: -12) {
                HStack(spacing: 8) {
                    VStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor((Color(IDQConstants.backgroundColor.withAlphaComponent(0.10))))
                                .frame(width: 40, height: 40)
                                .cornerRadius(6)
                            Rectangle()
                                .foregroundColor(Color(IDQConstants.backgroundColor.withAlphaComponent(0.70)))
                                .frame(width: 35, height: 35)
                                .cornerRadius(6)
                            image
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color(IDQConstants.basicFontColor))
                                .frame(width: 26, height: 26)
                        }
                        .padding(.top, 8)
                        Spacer()
                    }
                    .padding(.leading, 8)

                    VStack(spacing: 6) {
                        Text(title)
                            .frame(alignment: .leading)
                            .font(Font(IDQConstants.setFont(fontSize: 12, isBold: true)))
                            .foregroundColor(Color(IDQConstants.basicFontColor))
//                            .padding(.top, 12)
                        Text(subTitle)
                            .frame(alignment: .leading)
                            .font(Font(IDQConstants.setFont(fontSize: 9, isBold: false)))
                            .foregroundColor(Color(IDQConstants.basicFontColor))
//                            .padding(.bottom, 16)
                    }
                    Spacer()
                }
            }
        }
        
        
//        ZStack {
//            VStack {
//                Text(title)
//                    .frame(width: 80, height: 30, alignment: .center)
//                    .font(Font(IDQConstants.setFont(fontSize: 14, isBold: true)))
//                    .foregroundColor(Color(IDQConstants.basicFontColor))
//                    .kerning(2.35)
//                Text(subTitle)
//                    .frame(width: 80, height: 20, alignment: .center)
//                    .font(Font(IDQConstants.setFont(fontSize: 12, isBold: false)))
//                    .foregroundColor(Color(IDQConstants.basicFontColor))
//                    //.padding(.top, -35)
//            }
//        }
//        .overlay(
//            image
//                .resizable()
//                .scaledToFit()
//                .frame(width: 64, height: 64)
//                .padding(.leading, 32)
//                .padding(.top, 22)
//                .aspectRatio(contentMode: .fit)
//                .opacity(0.25)
//        )
//
    }
}

struct IDQSocialMediaView_Previews: PreviewProvider {
    static var previews: some View {
        IDQSocialMediaView(title: "Keep in touch", subTitle: "Follow me on Twitter", image: Image(uiImage: IDQConstants.twitterIcon))
    }
}
