//
//  LogInView.swift
//  HappyBurstDay
//
//  Created by Greem on 8/10/24.
//

import SwiftUI
enum SignInFocus{
    case email
    case password
}
struct SignInView:View{
    @State private var email:String = ""
    @State private var pw:String = ""
    @State private var isLoading:Bool = false
    @State private var showFailAlert:Bool = false
    @State private var signInAccess:Bool = false
    @FocusState var focus: SignInFocus?
    @StateObject var vm = SignInVM()
    @Environment(\.dismiss ) var dismiss
    var body: some View{
        ZStack{
            if isLoading{
                ProgressView().progressViewStyle(.circular)
            }else{
                VStack(spacing: 0){
                    Button{
                        Task{ await vm.check() }
                    }label: {
                        Text("Check")
                    }
                    HStack{
                        Button{ dismiss() }label: {
                            Image(.backIcon).frame(width: 13,height: 17)
                        }
                        Spacer()
                    }.padding(.horizontal,20).padding(.top,21)
                    HStack{
                        Text("SIGN IN").font(.Title.title1)
                        Spacer()
                    }.padding(.horizontal,20).padding(.vertical, 44)
                    ScrollView{
                        VStack(spacing: 41){
                            EmailField(text: $email, focus: $focus)
                            PasswordField(text: $pw, focus: $focus)
                        }.padding(.horizontal, 20)
                        Rectangle().fill(.clear).frame(height: 44)
                    }.scrollIndicators(.hidden)
                    if focus != nil{
                        Button(action: {
                            Task{  await vm.signIn(email:"wow12@google.com", pw:"1q2w3e4r") }
//                            Task{ await vm.check() }
                        }, label: {
                            HStack{
                                Spacer()
                                Text("LOGIN").font(.Title.title2)
                                Spacer()
                            }.frame(height: 68).background(.gray)
                        }).opacity(focus == nil ? 0 : 1)
                    }
                }
            }
        }.toolbar(.hidden, for: .navigationBar)
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
                print("signinaccess")
            case .signInLoading:
                isLoading = true
            }
        })
    }
    
}
extension SignInView{
    struct EmailField: View {
        @Binding var text: String
        var focus: FocusState<SignInFocus?>.Binding
        var body: some View {
            VStack(spacing:23) {
                HStack{
                    Text("Email").font(.Body.body2)
                    Spacer()
                }
                HStack{
                    VStack{
                        TextField("Enter Email", text: $text)
                            .font(.Body.body1)
                            .textFieldStyle(.plain).tint(.black)
                            .focused(focus, equals: .email)
                        Rectangle().fill(.black).frame(height: 1)
                    }
                }
            }
        }
    }
    struct PasswordField: View {
        @Binding var text: String
        var focus: FocusState<SignInFocus?>.Binding
        var body: some View {
            VStack(spacing:23) {
                HStack{
                    Text("Password").font(.Body.body2)
                    Spacer()
                }
                HStack{
                    VStack{
                        SecureField("Enter Password", text: $text)
                            .font(.Body.body1)
                            .textFieldStyle(.plain).tint(.black)
                            .focused(focus, equals: .email)
                        Rectangle().fill(.black).frame(height: 1)
                    }
                }
            }
        }
    }
}
#Preview {
    SignInView()
}
