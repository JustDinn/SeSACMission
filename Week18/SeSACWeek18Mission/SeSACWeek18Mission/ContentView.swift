//
//  ContentView.swift
//  SeSACWeek18Mission
//
//  Created by HyoTaek on 10/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("숫자 야구 게임")
                .font(.title)
                .fontWeight(.black)
                .frame(maxWidth: .infinity)
                .background(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

#Preview {
    ContentView()
}
