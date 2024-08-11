//
//  SignView.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import SwiftUI
enum SignPath{
    case signUp
    case signIn
    case birthDate
}
struct SignView: View {
    @State var pathes: [SignPath] = []
    @State private var isLoading = false
    var body: some View {
        NavigationStack(path: $pathes) {
            ZStack(content: {
                signBtns
            }).onAppear(){
                print(Defaults.shared.accessToken)
            }
            .navigationDestination(for: SignPath.self) { path in
                switch path{
                case .signIn: SignInView()
                case .signUp: SignUpView(pathes: $pathes)
                case .birthDate: BirthDateView()
                }
            }
        }
    }
    var signBtns: some View{
        ZStack{
            Image(.appLogo).resizable().scaledToFit().frame(width: 180)
            VStack{
                Spacer()
                VStack(spacing: 28){
                    HStack(spacing: 0){
                        Text("Don't have any account? ")
                        Button(action: {
                            pathes.append(.signUp)
                        }, label: {
                            Text("Sign Up").underline().tint(.darkMint).font(.pretendard(weight: .medium, size: 16))
                        })
                    }
                    Button(action: {
                        pathes.append(.signIn)
                    }, label: {
                        HStack{
                            Spacer()
                            Text("LOGIN").font(.Title.title2)
                            Spacer()
                        }.frame(height: 68).background(.darkMint).foregroundStyle(.white)
                    }).ignoresSafeArea(.container,edges: .bottom)
                }
            }
        }
    }
}
