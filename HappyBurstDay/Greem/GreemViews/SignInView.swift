//
//  LogInView.swift
//  HappyBurstDay
//
//  Created by Greem on 8/10/24.
//

import SwiftUI

struct SignInView:View{
    @State private var email:String = ""
    @State private var pw:String = ""
    @State private var isLoading:Bool = false
    @State private var showFailAlert:Bool = false
    @State private var signInAccess:Bool = false
    @StateObject var vm = SignInVM()
    var body: some View{
        ZStack{
            if isLoading{
                ProgressView().progressViewStyle(.circular)
            }else{
                VStack{
                    TextField("email", text: $email)
                    TextField("pw", text: $pw)
                    Button(action: {
                        Task{ await vm.signIn(email: email, pw: pw) }
                    }, label: {
                        Text("LogIn")
                    })
                }
            }
        }
        .alert("로그인이 실패했습니다", isPresented: $showFailAlert, actions: {
            Button(role: .cancel) {
                showFailAlert = false
            } label: {
                Text("확인")
            }
        })
        .onReceive(vm.event, perform: { @MainActor event in
            switch event{
            case .signInFailed:
                isLoading = false
                showFailAlert = true
            case .signInSuccess:
                isLoading = false
                signInAccess = true
            case .signInLoading:
                isLoading = true
            }
        })
    }
}

#Preview {
    SignInView()
}
