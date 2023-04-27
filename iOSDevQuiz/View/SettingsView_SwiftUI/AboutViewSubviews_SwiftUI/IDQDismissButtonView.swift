//
//  IDQDismissButtonView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/19/23.
//

import SwiftUI

struct IDQDismissButtonView: View {
    
    @Binding var isViewVisible: Bool
    
    var color: Color
    
    var body: some View {
        
        HStack(alignment: .center) {
            Button {
                isViewVisible = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(color)
                    .imageScale(.large)
                    .frame(width: 44, height: 44)
            }
            //.padding(.top, -60)
        }
    }
}

struct IDQDismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        IDQDismissButtonView(isViewVisible: .constant(false), color: .black)
    }
}
