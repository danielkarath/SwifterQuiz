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
        let settingsTitleOpacity: CGFloat = colorScheme == .light ? 0.15 : 0.11
        
        ScrollView {
            Text("Settings")
                .frame(width: UIScreen.main.bounds.width - 64, height: 50, alignment: .leading)
                .font(Font(IDQConstants.setFont(fontSize: 46, isBold: true)))
                .foregroundColor(Color(IDQConstants.secondaryFontColor.withAlphaComponent(settingsTitleOpacity)))
                .kerning(2.35)
                .padding(.bottom, -(UIScreen.main.bounds.height * 0.017))
            LazyVStack(spacing: 20) {
                ForEach(viewModel.cellViewModels) { viewModel in
                    IDQSettingsViewCell(cellTitle: viewModel.title, subTitle: viewModel.subtitle, image: Image(uiImage: viewModel.image!))
                        .frame(width: UIScreen.main.bounds.width - 64, height: 80, alignment: .leading)
                        .background(Color(IDQConstants.contentBackgroundColor))
                        .cornerRadius(16)
                        .simultaneousGesture(TapGesture().onEnded {
                            if viewModel.type == .about {
                                isAboutViewVisible.toggle()
                            } else if viewModel.type == .donate {
                                IDQInAppPurchaseManager.shared.purchase(.IDQ_BuyMeCoffee)
                            } else {
                                viewModel.onTapHandler(viewModel.type)
                            }
                        })
                        .highlightEffect(color: Color.white.opacity(0.5))
                }
            }
        }
        .shadow(color: colorScheme == .light ? Color.gray.opacity(0.40) : Color.clear, radius: 13, x: -2, y: 8)
        .fullScreenCover(isPresented: $isAboutViewVisible, content: {
            IDQAboutView(isAboutViewVisible: $isAboutViewVisible)
                .background(Color(IDQConstants.contentBackgroundColor))
                .ignoresSafeArea()
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
