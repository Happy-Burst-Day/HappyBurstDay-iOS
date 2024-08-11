//
//  SingUpPasswordCPT.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import SwiftUI

extension SignUpView{
    struct PasswordCPT: View {
        let desc:String
        let placeholder:String
        @Binding var pw:String
        var focus:FocusState<SignUpFocus?>.Binding
        let equals: SignUpFocus
        var body: some View {
            VStack(spacing:23) {
                HStack{
                    Text(desc).font(.Body.body2)
                    Spacer()
                }
                HStack{
                    VStack{
                        SecureField(placeholder, text: $pw)
                            .font(.Body.body1)
                            .textFieldStyle(.plain).tint(.black)
                            .focused(focus,equals: equals)
                        Rectangle().fill(.black).frame(height: 1)
                    }
                }
            }
        }
    }
}
