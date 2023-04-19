//
//  IDQAppIconView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/19/23.
//

import SwiftUI

struct IDQAppIconView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(IDQConstants.whiteColor))
                .cornerRadius(16)
            Rectangle()
                .foregroundColor(Color(IDQConstants.contentBackgroundColor))
                .frame(width: 95, height: 95)
                .cornerRadius(16)
            Image(uiImage: IDQConstants.appIconMiniature)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 48, height: 48)
        }
    }
}

struct IDQAppIconView_Previews: PreviewProvider {
    static var previews: some View {
        IDQAppIconView()
    }
}
