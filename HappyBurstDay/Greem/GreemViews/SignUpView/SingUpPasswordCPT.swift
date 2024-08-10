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
        @Binding var pw:String
        var body: some View {
            VStack(spacing:23) {
                HStack{
                    Text(desc).font(.Body.body2)
                    Spacer()
                }
                HStack{
                    VStack{
                        TextField("characters, 숫자 포함", text: $pw)
                            .font(.Body.body1)
                            .textFieldStyle(.plain).tint(.black)
                        Rectangle().fill(.black).frame(height: 1)
                    }
                }
            }
        }
    }
}
