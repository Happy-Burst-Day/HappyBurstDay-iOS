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
    @Binding var pathes:[SignPath]
    @State private var email = ""
    @State private var pw = ""
    @State private var dup = ""
    @State private var isLoading = false
    @State private var pwInfo:String = ""
    @State private var dupInfo:String = ""
    @State private var emailInfo = ""
    @State private var networkErrorOccured = false
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
                        PasswordCPT(desc: "characters at least 8 length",placeholder: "characters at least 8 length", pw: $pw,focus: $focusState,equals: .pw)
                        PasswordCPT(desc: "re-enter the password",placeholder: "re-enter the password",pw: $dup,focus: $focusState,equals: .email)
                    }
                }.padding(.horizontal, 20)
                Rectangle().fill(.clear).frame(height: 44)
            }.scrollIndicators(.hidden)
            Spacer()
            if focusState != nil{
                Button(action: {
                    guard dup != pw else{
                        return
                    }
                    Task{ 
                        do{
                            let userDto = try await vm.signUp(email:self.email, pw:self.pw)
                            try await vm.singIn(email: userDto.email, pw: self.pw)
                            await MainActor.run { pathes.append(.birthDate) }
                        }catch{
                            networkErrorOccured = true
                        }
                    }
                }, label: {
                    HStack{
                        Spacer()
                        Text("Sign Up").font(.Title.title2).foregroundStyle(.white)
                        Spacer()
                    }.frame(height: 68).background(.darkMint).tint(.darkMint)
                }).opacity(focusState == nil ? 0 : 1)
                    .alert("Error Occured", isPresented: $networkErrorOccured) {
                        Button(role: .cancel) {
                            networkErrorOccured = false
                        } label: {
                            Text("Confirm")
                        }

                    } 

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
                await MainActor.run { withAnimation { focusState = .email } }
            }
        }
    }
}

//#Preview {
//    SignUpView()
//}
