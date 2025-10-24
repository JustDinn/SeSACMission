//
//  ContentView.swift
//  SeSACWeek18Mission
//
//  Created by HyoTaek on 10/24/25.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Property
    
    @State private var inputNumber = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var resultList: [Result] = []
    private let correct: String = {
        let numbers = Array(0...9)
        let randomNumbers = numbers.shuffled().prefix(3).map { String($0) }.joined()
        return randomNumbers
    }()
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            Text("숫자 야구 게임")
                .font(.title)
                .fontWeight(.black)
                .padding(5)
                .frame(maxWidth: .infinity)
                .background(.white)
            
            Spacer()
            
            Text("시도 횟수: \(resultList.count)회")
                .frame(maxWidth: .infinity)
                .padding(6)
                .background(Color(uiColor: .systemGray4))
            
            HStack(spacing: 10) {
                TextField("3자리 숫자 입력", text: $inputNumber)
                    .padding(5)
                    .border(.gray, width: 1)
                Button("확인") {
                    if isValid(number: inputNumber) {
                        // 정답인 경우
                        if isCorrect {
                            showAlert = true
                            alertTitle = "게임 승리"
                            alertMessage = "3 스트라이크! 정답입니다! 🎉"
                        }
                        // 오답인 경우
                        else {
                            // 숫자 야구 결과를 result에 넣기
                            resultList.append(Result(input: inputNumber, result: ""))
                        }
                    } else {
                        showAlert = true
                    }
                }
                .tint(.white)
                .padding(6)
                .background(inputNumber.isEmpty ? Color(uiColor: .systemGray4) : .gray)
                .disabled(inputNumber.isEmpty)
                .cornerRadius(20)
            }
            .padding()
            .background(.white)
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
        .alert(alertTitle, isPresented: $showAlert) {
            Button("확인") { }
        } message: {
            Text(alertMessage)
        }
    }

    // MARK: - 유효성 검증

    private func isValid(number: String) -> Bool {

        // 모든 문자가 숫자인지 체크
        guard Int(number) != nil else {
            alertTitle = "입력 오류"
            alertMessage = "숫자만 입력할 수 있습니다."
            return false
        }

        // 3자리 숫자인지 체크
        guard number.count == 3 else {
            alertTitle = "입력 오류"
            alertMessage = "3자리 숫자를 입력해야합니다."
            return false
        }
        
        // 중복 체크

        return true
    }
    
    // MARK: - 숫자 야구 결과
    
    private var isCorrect: Bool {
        
        // 3S
        if inputNumber == correct {
            return true
        }
        else {
            return false
        }
    }
}

#Preview {
    ContentView()
}
