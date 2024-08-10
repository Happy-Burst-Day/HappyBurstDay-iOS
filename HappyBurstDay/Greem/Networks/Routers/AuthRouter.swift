//
//  SignRouters.swift
//  HappyBurstDay
//
//  Created by Greem on 8/10/24.
//

import Foundation
import Alamofire


enum AuthRouter: URLRequestConvertible{
    static let baseURL = URL(string: API_Key.baseURL + "/user")
    case user
    case signUp(email:String,pw:String,birthDate:Date)
    case signIn(email:String,pw:String)
    case reissue(accessToken:String, refreshToken: String)
    case changeChildbirth(date:Date)
    var endPath: String{
        switch self{
        case .signIn: "/login"
        case .signUp,.user: ""
        case .reissue: "/reissue"
        case .changeChildbirth: "/birthdate"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .user: .get
        case .signUp,.signIn,.reissue: .post
        case .changeChildbirth:.patch
        }
    }
    var headers:HTTPHeaders{
        var headers = HTTPHeaders()
        switch self{
        case .signIn,.signUp:
            headers["accept"] = "application/json;charset=UTF-8"
            headers["Content-Type"] = "application/json;charset=UTF-8"
        case .user: break
        case .reissue(accessToken: let accessToken, _ ):
            headers["Content-Type"] = "application/json;charset=UTF-8"
            headers["accept"] = "application/json;charset=UTF-8"
            headers["Authorization"] = "Bearer \(accessToken)"
        case .changeChildbirth:
            headers["Content-Type"] = "application/json;charset=UTF-8"
            headers["accept"] = "application/json;charset=UTF-8"
        }
        return headers
    }
    var params: Parameters{
        var params = Parameters()
        switch self{
        case .user: break
        case .signIn(let email,let pw):
            params["email"] = email
            params["password"] = pw
        case .signUp(let email,let pw, let birthDate):
            params["email"] = email
            params["password"] = pw
            let date = birthDate.yyyyMMdd
            params["birthDate"] = date
        case .reissue(refreshToken: let refreshToken):
            params["refreshToken"] = refreshToken
        case .changeChildbirth(date: let date):
            params["birthDate"] = date.yyyyMMdd
        }
        return params
    }
    
    func asURLRequest() throws -> URLRequest {
        guard var url = Self.baseURL else { return URLRequest(url: URL(string: "www.naver.com")!) }
        if endPath != "" { url = url.appendingPathComponent(endPath) }
        print(url)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        switch method{
        case .post:
            request.httpBody = try? JSONEncoding.default.encode(request, with: params).httpBody
        default: break
        }
        return request
    }
}
