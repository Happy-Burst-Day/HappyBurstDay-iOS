//
//  AuthInterceptor.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import Foundation
import Alamofire
final class AuthenticatorInterceptor:RequestInterceptor{
    let defaults = Defaults.shared
    var requiresRefresh: Bool {
        return if let expiration = defaults.expiration { Date() > expiration }else{ true }
    }
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
            var request = urlRequest
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(defaults.accessToken)", forHTTPHeaderField: "Authorization")
            completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard requiresRefresh else{
            completion(.doNotRetry)
            return
        }
        Task{
            do{
                let val = try await NetworkManager.shared.auth.reissue(accessToken: defaults.accessToken, refreshToken: defaults.refreshToken)
                defaults.expiration = Date(timeIntervalSince1970: NetworkManager.accessExpireSeconds)
                defaults.accessToken = val.accessToken
                defaults.refreshToken = val.refreshToken
                completion(.retry)
            }catch let fail where fail is NetworkErrors{ // 인증 실패(리프레시)를 제외하고 원래 로직을 따라가게 함...
                defaults.accessToken = ""
                completion(.doNotRetryWithError(fail as! NetworkErrors))
            }catch{
                completion(.doNotRetry)
            }
        }
    }
    
}
