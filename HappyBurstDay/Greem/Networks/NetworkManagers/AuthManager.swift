//
//  SignManager.swift
//  HappyBurstDay
//
//  Created by Greem on 8/10/24.
//

import Foundation
import Alamofire
extension NetworkManager{
    final class AuthManager{
        weak var delegate:NetworkManagerDelegate!
        init(delegate: NetworkManagerDelegate){
            self.delegate = delegate
        }
        
        func check() async throws -> UserDto{
            let router = AuthRouter.user
            return try await withCheckedThrowingContinuation { [weak self] continuation in
                guard let self else {return }
                AF.request(router,interceptor: delegate.baseInterceptor)
                    .validate(statusCode: 200..<300)
                    .response {res in
                    print(res.response?.statusCode)
                    switch res.result{
                    case .success(let data):
                        guard let data else {
                            continuation.resume(throwing: NetworkErrors.loginAccessError)
                            return
                        }
                        do{
                            let authDto = try JSONDecoder().decode(UserDto.self, from: data)
                            continuation.resume(returning: authDto)
                        }catch{
                            continuation.resume(throwing: NetworkErrors.loginAccessError)
                            return
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
        
        /// 회원가입
        func signUp(email:String,pw:String) async throws -> SignUpDto{
            let router = AuthRouter.signUp(email: email, pw: pw, birthDate: Date())
            return try await withCheckedThrowingContinuation {[weak self] continuation in
                AF.request(router)
//                    .validate(statusCode: 200..<300)
                    .response {[weak self] response in
                    print(response.response?.statusCode)
                        print(response.data?.count)
                    switch response.result{
                    case .success(let data):
                        guard let data else {
                            continuation.resume(throwing: NetworkErrors.signUpAccessError)
                            return
                        }
                        do{
                            let signUp = try JSONDecoder().decode(SignUpDto.self, from: data)
                            continuation.resume(returning: signUp)
                        }catch{
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        print(error)
                        continuation.resume(throwing: NetworkErrors.signUpAccessError)
                        return
                    }
                }
            }
            
        }
        /// 로그인
        func signIn(email:String,pw:String) async throws -> SignInDto{
            let router = AuthRouter.signIn(email: email, pw: pw)
            return try await withCheckedThrowingContinuation{[weak self] continuation in
                AF.request(router)
                    .validate(statusCode: 200..<300)
                    .response {[weak self] response in
                    switch response.result{
                    case .success(let data):
                        print(response.response?.statusCode)
                        guard let data else {
                            continuation.resume(throwing: NetworkErrors.loginAccessError)
                            return
                        }
                        do{
                            let signInDto = try JSONDecoder().decode(SignInDto.self, from: data)
                            Defaults.shared.accessToken = signInDto.accessToken
                            Defaults.shared.expiration = Date()
                            continuation.resume(returning: signInDto)
                        }catch{
                            continuation.resume(throwing: NetworkErrors.loginAccessError)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: NetworkErrors.loginAccessError)
                    }
                }
            }
        }
        func reissue(accessToken:String ,refreshToken: String) async throws -> ReissueDto{
            let router = AuthRouter.reissue(accessToken: accessToken, refreshToken: refreshToken)
            return try await withCheckedThrowingContinuation { continuation in
                AF.request(router).validate(statusCode: 200..<300).response { res in
                    switch res.result{
                    case .success(let data):
                        guard let data else {
                            continuation.resume(throwing: NetworkErrors.reissueError)
                            return
                        }
                        do{
                            let reissueDto = try JSONDecoder().decode(ReissueDto.self, from: data)
                            continuation.resume(returning: reissueDto)
                        }catch{
                            continuation.resume(throwing: NetworkErrors.reissueError)
                            return
                        }
                    case .failure(let fail):
                        continuation.resume(throwing: NetworkErrors.reissueError)
                        return
                    }
                }
            }
        }
        func changeChildBirth(date:Date) async throws -> UserDto{
            let router = AuthRouter.changeChildbirth(date: date)
            return try await withCheckedThrowingContinuation { continuation in
                AF.request(router,interceptor: delegate.baseInterceptor).response{ res in
                    switch res.result{
                    case .success(let data):
                        guard let data else {
                            continuation.resume(throwing: NetworkErrors.loginAccessError)
                            return
                        }
                        do{
                            let userDto = try JSONDecoder().decode(UserDto.self, from: data)
                            continuation.resume(returning: userDto)
                        }catch{
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}
