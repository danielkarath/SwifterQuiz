//
//  IDQWeeklyPointsChartView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/28/23.
//

import SwiftUI
import Charts

struct IDQWeeklyPointsChartView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var title: String
    var image: Image
    
    private let viewModel = IDQWeeklyPointsChartBarViewViewModel()
    @State var scoreForDayArray: [IDQScoreForDay] = []
    @State var scoreDifference: Int = 0
    
    var gradient: LinearGradient {
        let leadingColor = Color(IDQConstants.highlightFontColor)
        let trailingColor = Color(IDQConstants.basicFontColor)
        return LinearGradient(gradient: Gradient(colors: [leadingColor, trailingColor]),
                              startPoint: .bottomLeading,
                              endPoint: .topTrailing)
    }
    
    var body: some View {
        let frameWidth: CGFloat = UIScreen.screenHeight > 1080 ? (((UIScreen.screenWidth)/1.90) - 16) : 320+CGFloat((UIScreen.screenWidth - 2 * 160-100)/3)
        
        VStack {
            HStack {
                titleView(frameWidth: frameWidth)
                chnageView(frameWidth: frameWidth)
            }
            chartView(frameWidth: frameWidth)
                .onAppear() {
                    fetchDataAndUpdateState()
                }
        }
        .background(
            ZStack {
                backgroundImageView(frameWidth: frameWidth)
            }
        )
    }
    
    private func titleView(frameWidth: CGFloat) -> some View {
        let titleFont = Font(IDQConstants.setFont(fontSize: 18, isBold: false))
        let textColor = Color(uiColor: IDQConstants.basicFontColor)
        return IDQWeeklyPointsChartViewTitle(title: title, font: titleFont, fontColor: textColor)
            .frame(width: frameWidth/2)
    }
    
    private func chnageView(frameWidth: CGFloat) -> some View {
        let titleFont = Font(IDQConstants.setFont(fontSize: 14, isBold: false))
        let textColor = Color(uiColor: IDQConstants.basicFontColor)
        return IDQWeeklyPointsChangeView(titleValue: scoreDifference, font: titleFont, fontColor: textColor)
            .frame(width: frameWidth/2)
    }
    
    private func chartView(frameWidth: CGFloat) -> some View {
        Chart {
            ForEach(scoreForDayArray) { dayOfWeekScore in
                BarMark(x: .value("Day", dayOfWeekScore.day.rawValue), y: .value("score", dayOfWeekScore.score))
                    .foregroundStyle(gradient)
                    .cornerRadius(12)
            }
        }
        .frame(width: frameWidth, height: 120)
        .padding()
    }
    
    private func backgroundImageView(frameWidth: CGFloat) -> some View {
        return image
            .resizable()
            .frame(width: 220, height: 220)
            .offset(x: frameWidth*0.45)
            .offset(y: 50)
            .padding(.top, 16)
            .aspectRatio(contentMode: .fit)
            .scaledToFit()
            .opacity(0.055)
    }
    
    private func fetchDataAndUpdateState() {
        viewModel.generateThisWeeksResults { results in
            scoreForDayArray = results
            let startOfLastWeek: Date = Date().startOfWeek().addingTimeInterval(-3600*24*7)
            scoreDifference = viewModel.fetchResults(startOfLastWeek, Date().startOfWeek().addingTimeInterval(-60))
        }
    }
}

