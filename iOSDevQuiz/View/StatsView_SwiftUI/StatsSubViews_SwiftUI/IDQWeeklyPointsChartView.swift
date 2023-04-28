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
//    @State var highestTen: Int = 0
//    @State var yAxisArray: [Int] = [0, 5, 10, 15, 20]
    
    var body: some View {
        let titleFont = IDQConstants.setFont(fontSize: 18, isBold: false)
        let textColor = IDQConstants.basicFontColor
        let leadingColor = Color(IDQConstants.highlightFontColor)
        let trailingColor = Color(IDQConstants.basicFontColor)
        let gradient = LinearGradient(gradient: Gradient(colors: [leadingColor, trailingColor]),
                                      startPoint: .bottomLeading,
                                      endPoint: .topTrailing)
        let frameWidth: CGFloat = 320+CGFloat((UIScreen.screenWidth - 2 * 160-100)/3)
        
        VStack {
            HStack {
                Text(title)
                    .frame(width: 160, height: 21, alignment: .leading)
                    .font(Font(titleFont))
                    .foregroundColor(Color(textColor))
                    .kerning(2.35)
                    .padding(.top, 16)
                    .padding(.leading, 8)
                Spacer()
            }
            .frame(width: frameWidth)
            Chart {
                ForEach(scoreForDayArray) { dayOfWeekScore in
                    BarMark(x: .value("Day", dayOfWeekScore.day.rawValue), y: .value("score", dayOfWeekScore.score))
                        .foregroundStyle(gradient)
                        .cornerRadius(12)
                }
            }
//            .chartYAxis {
//                AxisMarks(
//                    format: Decimal.FormatStyle.number,
//                    values: yAxisArray
//                )
//            }
            .frame(width: frameWidth, height: 120)
            .padding()
            
        }
        .background(
            ZStack {
                image
                    .resizable()
                    .frame(width: 220, height: 220)
                    .offset(x: frameWidth*0.45)
                    .offset(y: 50)
                    .padding(.top, 16)
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .opacity(0.055)
            }
        )
        .onAppear() {
            var highestScore = 0
            viewModel.generateThisWeeksResults { results in
                scoreForDayArray = results
//                for result in results {
//                    if result.score > highestScore {
//                        highestScore = result.score
//                    }
//                }
//                let nearestTen = 10 * Int(ceil(Double(highestScore) / 10.0))
//                yAxisArray = generateDivisibleByFiveArray(upTo: nearestTen)
            }
        }
        
    }
    
    private func generateDivisibleByFiveArray(upTo nearestTen: Int) -> [Int] {
        var result = [Int]()
        for i in stride(from: 0, through: nearestTen, by: 5) {
            result.append(i)
        }
        return result
    }
    
}
