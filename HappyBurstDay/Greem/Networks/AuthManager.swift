//
//  SignManager.swift
//  HappyBurstDay
//
//  Created by Greem on 8/10/24.
//

import Foundation
import Alamofire

extension NetworkManager{
    class AuthManager{
        weak var delegate:NetworkManagerDelegate!
        init(delegate: NetworkManagerDelegate){
            self.delegate = delegate
        }
        /// 회원가입
        func signUp() async throws{
            return try await withCheckedThrowingContinuation { continuation in
                AF.request(AuthRouter.signUp).response { response in

                    switch response.result{
                    case .success(let data):
                        guard let data else {
                            continuation.resume(throwing: NetworkErrors.loginAccessError)
                            return
                        }
                        
                    case .failure(let error):
                        continuation.resume(throwing: NetworkErrors.loginAccessError)
                        return
                    }
                }
            }
            
        }
        /// 로그인
        func In(){
            
        }
    }
}
