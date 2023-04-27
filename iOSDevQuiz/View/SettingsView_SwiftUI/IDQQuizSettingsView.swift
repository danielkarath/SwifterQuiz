//
//  IDQQuizSettingsView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/26/23.
//

import SwiftUI

struct IDQQuizSettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel = IDQAboutViewViewModel()
    
    @Binding var isQuizSettingsVisible: Bool
    
    var topPaddingModifier: CGFloat = UIScreen.screenHeight >= 700 ? 0.10 : 0.16
    
    var body: some View {
        let cellWidth: CGFloat = UIScreen.screenWidth < 1000 ? UIScreen.screenWidth * 0.95 : 720
        VStack {
            IDQDismissButtonView(isAboutViewVisible: $isQuizSettingsVisible)
                .padding(.leading, cellWidth - 80)
                .padding(.top, UIScreen.screenHeight * topPaddingModifier)
        }
    }
}

struct IDQQuizSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        IDQQuizSettingsView(isQuizSettingsVisible: .constant(false))
    }
}
