//
//  IDQAboutView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/18/23.
//

import SwiftUI

struct IDQAboutView: View {
    
    private let appVersion: String = Bundle.main.appVersion ?? "1.0"
    @Binding var isAboutViewVisible: Bool
    
    var body: some View {
        let leadingColor = Color(IDQConstants.highlightedLightOrange)
        let trailingColor = Color(IDQConstants.highlightedDarkOrange)
        let gradient = LinearGradient(gradient: Gradient(colors: [leadingColor, trailingColor]),
                                      startPoint: .leading,
                                      endPoint: .topTrailing)
        
        ZStack {
            AddCurve()
                .fill(gradient)
            VStack(alignment: .center, spacing: 2) {
                Spacer()
                IDQDismissButtonView(isAboutViewVisible: $isAboutViewVisible)
                    .padding(.leading, UIScreen.main.bounds.width - 80)
                    .padding(.top, 16)
                Text("iOS Dev Quiz")
                    .font(Font(IDQConstants.setFont(fontSize: 24, isBold: true)))
                    .foregroundColor(Color(IDQConstants.whiteColor))
                Text("App version: \(appVersion)")
                    .font(Font(IDQConstants.setFont(fontSize: 14, isBold: false)))
                    .foregroundColor(Color(IDQConstants.whiteColor))
                Spacer()
                IDQAppIconView()
                    .frame(width: 100, height: 100)
                    .padding(.top, 24)
                Spacer(minLength: 600)
            }
            .padding(.top, 128)
        }
        .background(Color(IDQConstants.backgroundColor))
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
}
    //.frame(width: 300, height: 450)


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
