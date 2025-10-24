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
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text("숫자 야구 게임")
                .font(.title)
                .fontWeight(.black)
                .frame(maxWidth: .infinity)
                .background(.white)
            Spacer()
            HStack(spacing: 10) {
                TextField("3자리 숫자 입력", text: $number)
                    .padding(5)
                    .border(.gray, width: 1)
                Button("확인") {
                    print("확인 탭")
                }
                .padding(6)
                .background(Color(uiColor: .systemGray4))
            }
            .padding()
            .background(.white)
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

#Preview {
    ContentView(number: "")
}
