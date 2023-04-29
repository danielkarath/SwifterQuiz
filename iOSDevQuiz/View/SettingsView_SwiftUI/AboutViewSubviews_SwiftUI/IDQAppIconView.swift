//
//  IDQAppIconView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/19/23.
//

import SwiftUI

struct IDQAppIconView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(colorScheme == .light ? Color(IDQConstants.whiteColor) : Color(IDQConstants.blackColor))
                .cornerRadius(16)
            Rectangle()
                .foregroundColor(Color(IDQConstants.contentBackgroundColor))
                .frame(width: 95, height: 95)
                .cornerRadius(16)
            Image(uiImage: IDQConstants.appIconMiniature)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
        }
    }
}

struct IDQAppIconView_Previews: PreviewProvider {
    static var previews: some View {
        IDQAppIconView()
    }
}
