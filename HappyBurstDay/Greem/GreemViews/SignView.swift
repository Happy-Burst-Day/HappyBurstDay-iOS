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
            VStack{
                Spacer()
                VStack{
                    HStack(spacing: 0){
                        Text("Don't have any account? ")
                        Button(action: {
                            pathes.append(.signUp)
                        }, label: {
                            Text("Sign Up").underline()
                        })
                    }
                    Button(action: {
                        pathes.append(.signIn)
                    }, label: {
                        Text("LogIn")
                    }).ignoresSafeArea(.container,edges: .bottom)
                }
            }.onAppear(){
                print(Defaults.shared.accessToken)
            }
            .navigationDestination(for: SignPath.self) { path in
                switch path{
                case .signIn: SignInView()
                case .signUp: SignUpView()
                case .birthDate: BirthDateView()
                }
            }
        }
    }
}
