//
//  SignUpVM.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import Foundation
import Combine

final class SignUpVM: ObservableObject{
    @MainActor let event = PassthroughSubject<Event,Never>()
    func signUp(email:String,pw:String) async{
        do{
            await MainActor.run{event.send(.signUpLoading)}
            let signUpDto = try await NetworkManager.shared.auth.signUp(email: email, pw: pw)
            await MainActor.run { event.send(.signUpSuccess(signUpDto)) }
        }catch{
            print(error)
            await MainActor.run { event.send(.signUpFailed) }
        }
    }
    enum Event{
        case signUpSuccess(SignUpDto)
        case signUpFailed
        case signUpLoading
    }
}
