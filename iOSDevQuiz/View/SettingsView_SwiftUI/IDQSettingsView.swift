//
//  IDQSettingsView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/18/23.
//

import SwiftUI

struct IDQSettingsView: View {
    
    let viewModel: IDQSettingsViewViewModel
    
    @State private var isAboutViewVisible = false
    
    init(viewModel: IDQSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer(minLength: 32)
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.cellViewModels) { viewModel in
                        HStack {
                            if let image = viewModel.image,
                               let backgroundColor = viewModel.iconContainerColor
                            {
                                Image(uiImage: image)
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(9)
                                    .background(Color(backgroundColor))
                                    .cornerRadius(6)
                                    .padding(8)
                            }
                            Text("\(viewModel.title)")
                                .frame(width: 160, height: 30, alignment: .leading)
                                .font(Font(IDQConstants.setFont(fontSize: 14, isBold: false)))
                                .foregroundColor(Color(IDQConstants.basicFontColor))
                                .kerning(2.35)
                        }
                        .contentShape(Rectangle())
                        .frame(width: UIScreen.main.bounds.width - 32, height: 60, alignment: .leading)
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
        }
        .background(Color(IDQConstants.backgroundColor))
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
//        .overlay(
//            Group {
//                if isAboutViewVisible {
//                    VStack {
//                        Spacer()
//                        IDQAboutView()
//                            .frame(width: 300, height: 450)
//                            .background(Color(IDQConstants.contentBackgroundColor))
//                            .cornerRadius(20)
//                            .padding()
//                            .shadow(radius: 24)
//                            .opacity(isAboutViewVisible ? 1 : 0)
//                            .scaleEffect(isAboutViewVisible ? 1 : 0, anchor: .bottom)
//                            .animation(.spring(response: 0.8, dampingFraction: 0.7), value: isAboutViewVisible)
//
//                            .offset(y: isAboutViewVisible ? -UIScreen.main.bounds.height/4 :  -UIScreen.main.bounds.height)
//                            .onTapGesture {
//                                withAnimation(.easeInOut(duration: 1.0)) {
//                                    isAboutViewVisible.toggle()
//                                }
//                            }
//                    }
//                    .transition(.move(edge: .bottom))
//                    .animation(.easeInOut(duration: 1.8))
//                }
//            }
//        )
        
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
