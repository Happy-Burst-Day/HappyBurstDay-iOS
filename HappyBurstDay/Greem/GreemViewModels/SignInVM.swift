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
            try await NetworkManager.shared.auth.signIn()
            event.send(.signInSuccess)
        }catch{
            event.send(.signInFailed)
        }
    }
    enum Event{
        case signInSuccess
        case signInFailed
        case signInLoading
    }
}
