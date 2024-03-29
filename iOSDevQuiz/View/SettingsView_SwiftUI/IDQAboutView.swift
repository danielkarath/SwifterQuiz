//
//  IDQAboutView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/18/23.
//

import SwiftUI

struct IDQAboutView: View {
        
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel = IDQAboutViewViewModel()
    
    @Binding var isAboutViewVisible: Bool
    
    private let appVersion: String = Bundle.main.appVersion ?? "1.0"
    private let aboutDescriptionText = "Thank you for downloading my app! I'm Daniel and I'm the developer of the application you're using. I'd a blast building this app & I hope you'll have a great time using it.\n\nIf you'd like to give me some feedback, feel free to send me an e-mail or contact me via Twitter."
    var topPaddingModifier: CGFloat = UIScreen.screenHeight >= 700 ? 0.10 : 0.16
    var topSpacerModifier: CGFloat = UIScreen.screenHeight >= 700 ? 0.08 : 0.015
    
    var body: some View {
        let cellWidth: CGFloat = UIScreen.screenWidth < 1000 ? UIScreen.screenWidth * 0.95 : 720
        let leadingColor = Color(IDQConstants.highlightedLightOrange)
        let trailingColor = Color(IDQConstants.highlightedDarkOrange)
        let gradient = LinearGradient(gradient: Gradient(colors: [leadingColor, trailingColor]),
                                      startPoint: .leading,
                                      endPoint: .topTrailing)
        ZStack {
            AddCurve()
                .fill(gradient)
            VStack(alignment: .center, spacing: 2) {
                HStack {
                    Spacer()
                    IDQDismissButtonView(isViewVisible: $isAboutViewVisible, color: .white)
                }
                .padding(.trailing, 16)
                .padding(.top, UIScreen.screenHeight * topPaddingModifier)
                Spacer(minLength: UIScreen.screenHeight * topSpacerModifier)
                Text("Swifter Quiz")
                    .font(Font(IDQConstants.setFont(fontSize: 24, isBold: true)))
                    .foregroundColor(Color(IDQConstants.whiteColor))
                Text("App version: \(appVersion)")
                    .font(Font(IDQConstants.setFont(fontSize: 14, isBold: false)))
                    .foregroundColor(Color(IDQConstants.whiteColor))
                    .padding(.bottom, 16)
                IDQAppIconView()
                    .frame(width: 100, height: 100)
                Spacer(minLength: UIScreen.screenHeight * 0.10)
                IDQAboutTextView(title: "Hey there!", description: aboutDescriptionText)
                    .frame(width: cellWidth - 64, height: 180)
                    .shadow(color: colorScheme == .light ? Color.gray.opacity(0.40) : Color.clear, radius: 5, x: 0, y: 5)
                    .padding(.bottom, 16)
                HStack(spacing: 16) {
                    IDQSocialMediaView(title: "Keep in touch", subTitle: "Twitter", image: Image(uiImage: IDQConstants.twitterIcon))
                        .frame(width: cellWidth/2 - 24, height: 60)
                        .shadow(color: colorScheme == .light ? Color.gray.opacity(0.40) : Color.clear, radius: 5, x: 0, y: 5)
                        .onTapGesture {
                            viewModel.didTap(on: .twitter)
                        }
                    IDQSocialMediaView(title: "Contribute", subTitle: "Source Code", image: Image(systemName: "hammer.fill"))
                        .frame(width: cellWidth/2 - 24, height: 60)
                        .shadow(color: colorScheme == .light ? Color.gray.opacity(0.40) : Color.clear, radius: 5, x: 0, y: 5)
                        .onTapGesture {
                            viewModel.didTap(on: .viewCode)
                        }
                }
                .frame(width: cellWidth - 64, height: 70)
                Spacer(minLength: UIScreen.screenHeight * 0.30)
            }
        }
        .background(Color(IDQConstants.backgroundColor))
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
}


struct AddCurve: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY-86))
            
            path.addCurve(to: CGPoint(x: rect.maxX, y: rect.midY-40), control1: CGPoint(x: rect.midX-70, y: rect.midY-40), control2: CGPoint(x: rect.midX+20, y: rect.minY+90))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minX))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}

struct IDQAboutView_Previews: PreviewProvider {
    static var previews: some View {
        IDQAboutView(isAboutViewVisible: .constant(false))
    }
}
