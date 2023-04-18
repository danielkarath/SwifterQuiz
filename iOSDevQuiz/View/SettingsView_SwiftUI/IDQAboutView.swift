//
//  IDQAboutView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/18/23.
//

import SwiftUI

struct IDQAboutView: View {
    var body: some View {
        VStack {
            Text("Hej world")
            Rectangle()
                .frame(width: 120, height: 120)
        }
    }

}

struct IDQAboutView_Previews: PreviewProvider {
    static var previews: some View {
        IDQAboutView()
    }
}
