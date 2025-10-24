//
//  ContentView.swift
//  SeSACWeek18Mission
//
//  Created by HyoTaek on 10/24/25.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Property
    
    @State var inputNumber: String = ""
    private var resultList: [Result] = []
    
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
                    print("확인 탭")
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
    }

    // MARK: - 유효성 검증

    private func isValid(number: String) -> Bool {
        
        // 빈 문자열 체크
        guard !number.isEmpty else { return false }

        // 모든 문자가 숫자인지 체크
        guard Int(number) != nil else { return false }

        // 3자리 숫자인지 체크
        guard number.count == 3 else { return false }

        return true
    }
}

#Preview {
    ContentView()
}
