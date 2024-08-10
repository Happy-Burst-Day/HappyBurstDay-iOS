//
//  SignUpView.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import SwiftUI
enum SignUpFocus{
    case email
    case pw
    case dup
}
struct SignUpView: View {
    @Environment(\.navigationControllerState) var naviState
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: SignUpVM = .init()
    @State private var email = ""
    @State private var pw = ""
    @State private var dup = ""
    @State private var isLoading = false
    @FocusState var focusState: SignUpFocus?
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Button{ dismiss() }label: {
                    Image(.backIcon).frame(width: 13,height: 17)
                }
                Spacer()
            }.padding(.horizontal,20).padding(.top,21)
            HStack{
                Text("SIGN UP").font(.Title.title1)
                Spacer()
            }.padding(.horizontal,20).padding(.vertical, 44)
            ScrollView{
                VStack(spacing: 41){
                    EmailCPT(email: $email, focus: $focusState, duplicateAction: {
                        
                    })
                    VStack(spacing: 25){
                        PasswordCPT(desc: "character, 숫자 포함", pw: $pw)
                        PasswordCPT(desc: "영문, 숫자 포함",pw: $dup)
                    }
                }.padding(.horizontal, 20)
                Rectangle().fill(.clear).frame(height: 44)
            }.scrollIndicators(.hidden)
            Spacer()
            if focusState != nil{
                Button(action: {
                    Task{  await vm.signUp(email:"wow12@google.com", pw:"1q2w3e4r") }
                }, label: {
                    HStack{
                        Spacer()
                        Text("회원가입").font(.Title.title2)
                        Spacer()
                    }.frame(height: 68).background(.gray)
                }).opacity(focusState == nil ? 0 : 1)
            }
        }.toolbar(.hidden, for: .navigationBar)
            .onReceive(vm.event, perform: { @MainActor event in
                switch event{
                case .signUpFailed: 
                    print("SignUp is Failed")
                    isLoading = false
                case .signUpLoading: isLoading = true
                case .signUpSuccess(let info):
                    print("signUp Success \(info))")
                    isLoading = false
                }
            })
        .onAppear(){
            naviState.allowsSwipeBack = true
            Task{
                try await Task.sleep(nanoseconds: 100)
                await MainActor.run {
                    withAnimation { focusState = .email }
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}
