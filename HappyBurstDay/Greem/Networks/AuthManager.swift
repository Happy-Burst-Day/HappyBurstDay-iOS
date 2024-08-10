//
//  SignManager.swift
//  HappyBurstDay
//
//  Created by Greem on 8/10/24.
//

import Foundation
import Alamofire

final class Defaults{
    static let shared = Defaults()
    init(){ }
    var accessToken:String {
        get{ UserDefaults.standard.string(forKey: "AccessToken") ?? "" }
        set{ UserDefaults.standard.setValue(newValue, forKey: "AccessToken") }
    }
    var refreshToken:String {
        get{ UserDefaults.standard.string(forKey: "RefreshToken") ?? "" }
        set{ UserDefaults.standard.setValue(newValue, forKey: "RefreshToken") }
    }
    var email:String?{
        get{ UserDefaults.standard.string(forKey: "UserEmail") }
        set{ UserDefaults.standard.setValue(newValue, forKey: "UserEmail") }
    }
    var birthDate:String?{
        get{ UserDefaults.standard.string(forKey: "UserBirthDate") }
        set{ UserDefaults.standard.setValue(newValue, forKey: "UserBirthDate") }
    }
    var expiration: Date?{
        get{
            let dateString = UserDefaults.standard.string(forKey: "expiration") ?? ""
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = formatter.date(from: dateString)
            return date
        }
        set{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let newValue{
                let dateStr = formatter.string(from: newValue)
                UserDefaults.standard.setValue(dateStr,forKey: "expiration")
            }
        }
    }
}

extension NetworkManager{
    final class AuthManager{
        weak var delegate:NetworkManagerDelegate!
        init(delegate: NetworkManagerDelegate){
            self.delegate = delegate
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
        func signIn() async throws{
            let router = AuthRouter.signIn(email: "", pw: "")
            return try await withCheckedThrowingContinuation{[weak self] continuation in
                AF.request(router).response {[weak self] response in
                    switch response.result{
                    case .success(let data):
                        guard let data else {
                            continuation.resume(throwing: NetworkErrors.loginAccessError)
                            return
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
    }
}
