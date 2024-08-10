//
//  SignUpEmailCPT.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import SwiftUI

extension SignUpView{
    struct EmailCPT: View {
        @Binding var email: String
        var focus:FocusState<SignUpFocus?>.Binding
        var duplicateAction:(()->())?
        var body: some View {
            Section {
                HStack{
                    VStack{
                        TextField("영문, 숫자 포함", text: $email)
                            .textFieldStyle(.plain)
                            .font(.Body.body1)
                            .focused(focus,equals: .email)
                            .tint(.black)
                        Rectangle().fill(.black).frame(height: 1)
                    }
                    Button{
                        duplicateAction?()
                    }label: {
                        Text("중복확인")
                            .font(.Body.body2)
                            .padding(.horizontal,16).padding(.vertical,8)
                            .background{
                                Capsule().stroke().fill(.black)
                            }
                    }
                }
            } header: {
                HStack{
                    Text("Email").font(.Body.body2)
                    Spacer()
                }
            }
        }
    }
}
