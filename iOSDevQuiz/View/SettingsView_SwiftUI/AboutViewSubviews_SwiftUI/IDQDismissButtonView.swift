//
//  IDQDismissButtonView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/19/23.
//

import SwiftUI

struct IDQDismissButtonView: View {
    
    @Binding var isAboutViewVisible: Bool
    
    var body: some View {
        
        HStack(alignment: .center) {
            Button {
                isAboutViewVisible = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .imageScale(.large)
                    .frame(width: 44, height: 44)
            }
            //.padding(.top, -60)
        }
    }
}

struct IDQDismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        IDQDismissButtonView(isAboutViewVisible: .constant(false))
    }
}
