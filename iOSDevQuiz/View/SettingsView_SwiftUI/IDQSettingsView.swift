//
//  IDQSettingsView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/18/23.
//

import SwiftUI

struct IDQSettingsView: View {
    
    let viewModel: IDQSettingsViewViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isAboutViewVisible = false
    
    init(viewModel: IDQSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            Text("Settings")
                .frame(width: UIScreen.main.bounds.width - 64, height: 50, alignment: .leading)
                .font(Font(IDQConstants.setFont(fontSize: 46, isBold: true)))
                .foregroundColor(Color(IDQConstants.secondaryFontColor.withAlphaComponent(0.12)))
                .kerning(2.35)
                .padding(.bottom, -(UIScreen.main.bounds.height * 0.017))
            LazyVStack(spacing: 24) {
                ForEach(viewModel.cellViewModels) { viewModel in
                    IDQSettingsViewCell(cellTitle: viewModel.title, subTitle: viewModel.subtitle, image: Image(uiImage: viewModel.image!))
                        .frame(width: UIScreen.main.bounds.width - 64, height: 72, alignment: .leading)
                        .background(Color(IDQConstants.contentBackgroundColor))
                        .cornerRadius(8)
                        .onTapGesture {
                            if viewModel.type == .about {
                                isAboutViewVisible.toggle()
                            } else {
                                viewModel.onTapHandler(viewModel.type)
                            }
                        }
                }
            }
        }
        .shadow(color: colorScheme == .light ? Color.gray.opacity(0.40) : Color.clear, radius: 13, x: -2, y: 8)
        .fullScreenCover(isPresented: $isAboutViewVisible, content: {
            IDQAboutView(isAboutViewVisible: $isAboutViewVisible)
                .background(Color(IDQConstants.contentBackgroundColor))
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        //isAboutViewVisible.toggle()
                    }
                }
        })
        .background(Color(IDQConstants.backgroundColor))
    }
}

struct IDQSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        IDQSettingsView(
            viewModel: .init(
                cellViewModels: IDQSettingsOption.allCases.compactMap({
                    return IDQSettingsCellViewModel(type: $0, onTapHandler: {
                        option in
                        
                    })
                })
            )
        )
    }
}
