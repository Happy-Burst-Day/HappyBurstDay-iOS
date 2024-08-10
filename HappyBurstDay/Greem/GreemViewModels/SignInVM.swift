//
//  SignInVM.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import Foundation
import Combine

final class SignInVM: ObservableObject{
//    @Published var email:String = ""
//    @Published var pw:String = ""
    let event = PassthroughSubject<Event,Never>()
    func signIn(email:String,pw:String) async {
        do{
            await MainActor.run { event.send(.signInLoading) }
            let signInDto = try await NetworkManager.shared.auth.signIn(email: email, pw: pw)
            
            await MainActor.run {
                Defaults.shared.accessToken = signInDto.accessToken
                Defaults.shared.refreshToken = signInDto.refreshToken
                Defaults.shared.expiration = Date()
                event.send(.signInSuccess)
            }
        }catch{
            print(error)
            await MainActor.run {
                event.send(.signInFailed)
            }
        }
    }
    func check() async{
        do{
            await MainActor.run { event.send(.signInLoading) }
            let userDto = try await NetworkManager.shared.auth.check()
            print(userDto)
            await MainActor.run { event.send(.signInSuccess) }
        }catch{
            print(error)
            await MainActor.run {
                event.send(.signInFailed)
            }
        }
    }
    enum Event{
        case signInSuccess
        case signInFailed
        case signInLoading
    }
}
