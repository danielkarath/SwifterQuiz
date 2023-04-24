//
//  IDQStatsView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import SwiftUI
import CoreData

struct IDQStatsView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var totalScore: Double
    var totalPerformance: Double
    var quizesPlayed: Double
    var timeSpent: Double
    var streak: Double
    
    private let viewModel = IDQStatsViewViewModel()
    
    @State private var modifiedPadding: CGFloat = 0
    @State private var midOffset: CGFloat = 0
    @State private var orientation: Bool = UIDevice.isLandscape
    private let isInitiallyLandscape: Bool = UIDevice.isLandscape
    
    private func getModifiedPadding(isLandscape: Bool) {
        var value: CGFloat?
        if isLandscape {
            if UIScreen.screenHeight < 1300 {
                value = -1700
            } else {
                value = -2000
            }
        } else {
            if isInitiallyLandscape {
                if UIScreen.screenHeight < 1300 {
                    value = -1500
                } else {
                    value = -1800
                }
            } else {
                if UIScreen.screenHeight < 700 {
                    value = -800
                } else if UIScreen.screenHeight < 900 {
                    value = -820
                } else if UIScreen.screenHeight < 1000 {
                    value = -860
                } else if UIScreen.screenHeight < 1300 {
                    value = -1500
                } else {
                    value = -1800
                }
            }
        }
        modifiedPadding = value!
    }
    
    private func getMidModifier(isLandscape: Bool) {
        var value: CGFloat?
        if isLandscape {
            if UIScreen.screenHeight < 1300 {
                value = 130
            } else {
                value = 60
            }
        } else {
            if isInitiallyLandscape {
                if UIScreen.screenHeight < 1300 {
                    value = 150
                } else {
                    value = 70
                }
            } else {
                if UIScreen.screenHeight < 700 {
                    value = 240
                } else if UIScreen.screenHeight < 900 {
                    value = 300
                } else if UIScreen.screenHeight < 1000 {
                    value = 325
                } else if UIScreen.screenHeight < 1100 {
                    value = 260
                } else {
                    value = 90
                }
            }
        }
        midOffset = value!
    }
    
    var body: some View {
        ZStack {
            IDQStatsUpperView()
                .foregroundColor(Color(IDQConstants.contentBackgroundColor))
                .frame(maxWidth: .infinity)
                .frame(height: 700)
                .padding(.top, modifiedPadding)
            VStack {
                ZStack {
                    VStack {
                        IDQMainStatsView(totalScore: totalScore, totalPerformance: totalPerformance, streak: streak)
                    }
                    VStack {
                        Spacer(minLength: midOffset)
                        ScrollView(.vertical) {
                            IDQStatsMetricsHStackView(quizesPlayed: quizesPlayed, timeSpent: viewModel.setupGameTime(for: timeSpent), gameTimeText: viewModel.setupTextFor(totalGameTime: timeSpent))
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
        }
        .ignoresSafeArea()
        .background(Color(IDQConstants.backgroundColor))
        .onAppear {
            getModifiedPadding(isLandscape: orientation)
            getMidModifier(isLandscape: orientation)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)) { _ in
                if UIScreen.screenHeight > 1000 {
                    orientation.toggle()
                    getModifiedPadding(isLandscape: orientation)
                    getMidModifier(isLandscape: orientation)
                }
            }
    }
    
}

struct IDQStatsView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsView(totalScore: 28, totalPerformance: 0.87, quizesPlayed: 23, timeSpent: 9048, streak: 2)
    }
}
