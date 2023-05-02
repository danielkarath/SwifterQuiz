//
//  IDQQuizSettingsView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/26/23.
//

import SwiftUI
struct IDQQuizSettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var viewModel = IDQQuestionManager()
    @State private var questionArray: [IDQQuestion]?
    @State private var selectedItemIndex: Int?
    @State private var isConfirmationAlertPresented = false
    
    @Binding var isQuizSettingsVisible: Bool
    
    var topPaddingModifier: CGFloat = UIScreen.screenHeight >= 700 ? 0.05 : 0.03
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(IDQConstants.backgroundColor))
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("Disabled Questions")
                        .font(Font(IDQConstants.setFont(fontSize: 20, isBold: false)))
                        .foregroundColor(Color(IDQConstants.basicFontColor))
                        .padding(.leading, 16)
                    Spacer()
                    IDQDismissButtonView(isViewVisible: $isQuizSettingsVisible, color: Color(uiColor: IDQConstants.basicFontColor))
                }
                .padding(.trailing, 16)
                .padding(.top, UIScreen.screenHeight * topPaddingModifier)
                VStack {
                    if let questions = questionArray {
                        if !questions.isEmpty {
                            List(Array(questions.indices), id: \.self) { index in
                                Button(action: {
                                    selectedItemIndex = index
                                    isConfirmationAlertPresented = true
                                }, label: {
                                    Text(questions[index].question ?? "")
                                        .font(Font(IDQConstants.setFont(fontSize: 16, isBold: false)))
                                        .foregroundColor(Color(IDQConstants.basicFontColor))
                                })
                            }
                            .background(Color(IDQConstants.backgroundColor))
                            .scrollContentBackground(.hidden)
                            .alert(isPresented: $isConfirmationAlertPresented, content: {
                                let question = questionArray?[selectedItemIndex ?? 0]
                                return Alert(
                                    title: Text("Enable question"),
                                    message: Text("Do you want to enable the question:\n\n \"\(question?.question ?? "")\"\n\nThis action will restore the question, meaning that you may get this question again when taking quizes."),
                                    primaryButton: .cancel(Text("Enable")) {
                                        if let question = questionArray?[selectedItemIndex ?? 0] {
                                            viewModel.removeDisable(question)
                                            questionArray = viewModel.fetchQuestionArray(for: .disabled)
                                        }
                                    },
                                    secondaryButton: .default(Text("Keep disabled")) {
                                        print("Question left in disabled")
                                    }
                                )
                            })
                        } else {
                            Text("No questions found")
                                .font(Font(IDQConstants.setFont(fontSize: 12, isBold: false)))
                                .foregroundColor(Color(IDQConstants.basicFontColor))
                        }
                    } else {
                        Text("No questions found")
                            .font(Font(IDQConstants.setFont(fontSize: 12, isBold: false)))
                            .foregroundColor(Color(IDQConstants.basicFontColor))
                    }
                }
                .padding(.top, -16)
                Spacer()
            }
            .padding(.top, 16)
        }
        .onAppear() {
            questionArray = viewModel.fetchQuestionArray(for: .disabled) ?? []
        }
    }
}

struct IDQQuizSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        IDQQuizSettingsView(isQuizSettingsVisible: .constant(false))
    }
}
