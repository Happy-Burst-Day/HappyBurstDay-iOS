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
                VStack(spacing: 8){
                    HStack{
                        VStack(spacing: 9){
                            HStack{
                                TextField("ex. mommytalk@gmail.com", text: $email)
                                    .textFieldStyle(.plain)
                                    .font(.Body.body1)
                                    .focused(focus,equals: .email)
                                    .keyboardType(.emailAddress)
                                    .tint(.black)
                                Button{
                                    self.email = ""
                                }label: {
                                    Image(.closeIcon).font(.system(size: 14))
                                }
                            }
                            
                            Rectangle().fill(.black).frame(height: 1)
                            
                        }
                        Button{
                            duplicateAction?()
                        }label: {
                            Text("중복확인")
                                .font(.Body.body2)
                                .foregroundStyle(.darkMint)
                                .padding(.horizontal,16).padding(.vertical,8)
                                .background{
                                    Capsule().stroke().fill(.darkMint)
                                }
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
