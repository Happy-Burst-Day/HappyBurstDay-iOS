//
//  HappyBurstDayApp.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/9/24.
//

import SwiftUI

@main
struct HappyBurstDayApp: App {
    @State var isLogIn = false
    var body: some Scene {
        WindowGroup {
            Group{
                if isLogIn{
                    MainView()
                }else{
                    SignView()
                }
            }.onReceive(AppManager.shard.loginPassthroughSubject, perform: { isLogIn in
                Task{
                    print(isLogIn)
                    try await Task.sleep(nanoseconds:1000)
                    await MainActor.run {
                        self.isLogIn = isLogIn
                    }
                }
            })
//            MainView()
//            ContentView()
            
//            SearchView()
//            NavigationStack {
//                BirthDateView().toolbar(.hidden, for: .navigationBar)
//            }
        }
    }
}
