//
//  ContentView.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
                .font(.Headline.headline)
            // 이렇게 쓰면 됨!!
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
