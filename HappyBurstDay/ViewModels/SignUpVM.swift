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
    func signUp(email:String,pw:String) async throws -> UserDto{
        do{
            await MainActor.run{event.send(.signUpLoading)}
            let signUpDto = try await NetworkManager.shared.auth.signUp(email: email, pw: pw)
            await MainActor.run { event.send(.signUpSuccess(signUpDto)) }
            return UserDto(email: signUpDto.email, birthDate: signUpDto.birthDate)
        }catch{
            print(error)
            await MainActor.run { event.send(.signUpFailed) }
            throw error
        }
    }
    func singIn(email:String,pw:String) async throws{
        let signInDto = try await NetworkManager.shared.auth.signIn(email: email, pw: pw)
        Defaults.shared.accessToken = signInDto.accessToken
        Defaults.shared.refreshToken = signInDto.refreshToken
    }
    enum Event{
        case signUpSuccess(SignUpDto)
        case signUpFailed
        case signUpLoading
    }
}
