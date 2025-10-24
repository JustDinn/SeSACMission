//
//  ContentView.swift
//  SeSACWeek18Mission
//
//  Created by HyoTaek on 10/24/25.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Property
    
    @State var number: String = ""
    private var tryCounting: Int = 0
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            Text("숫자 야구 게임")
                .font(.title)
                .fontWeight(.black)
                .frame(maxWidth: .infinity)
                .background(.white)
            
            Spacer()
            
            Text("시도 횟수: \(tryCounting)회")
                .frame(maxWidth: .infinity)
                .padding(6)
                .background(Color(uiColor: .systemGray4))
            
            HStack(spacing: 10) {
                TextField("3자리 숫자 입력", text: $number)
                    .padding(5)
                    .border(.gray, width: 1)
                Button("확인") {
                    print("확인 탭")
                }
                .tint(.white)
                .padding(6)
                .background(number.isEmpty ? Color(uiColor: .systemGray4) : .gray)
                .disabled(number.isEmpty)
            }
            .padding()
            .background(.white)
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

#Preview {
    ContentView()
}
