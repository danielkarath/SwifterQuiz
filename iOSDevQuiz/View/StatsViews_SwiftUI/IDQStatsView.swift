//
//  IDQStatsView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import SwiftUI

struct IDQStatsView: View {
    let titleFont = IDQConstants.setFont(fontSize: 32, isBold: true)
    
    @StateObject private var viewModel = IDQStatsViewViewModel()
    
    
    var body: some View {
        ZStack {
            IDQStatsUpperView()
                .frame(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.width*2)
                .cornerRadius(UIScreen.main.bounds.width)
                .padding(.top, -UIScreen.main.bounds.width*2.20)
            VStack {
                Text("Progression")
                    .frame(width: UIScreen.main.bounds.width-64, height: 50, alignment: .leading)
                    .foregroundColor(Color(IDQConstants.whiteColor))
                    .font(Font(titleFont))
                    .multilineTextAlignment(.leading)
                    .padding(.top, 16)
                Spacer()
            }
        }
        .onAppear {
            viewModel.fetchMonthlyMetrics()
            print("viewModel.results: \(viewModel.results)")
        }
    }
}

struct IDQStatsView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsView()
    }
}
