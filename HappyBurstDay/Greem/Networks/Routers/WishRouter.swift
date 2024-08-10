//
//  WishRouter.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import Foundation
import Alamofire

enum WishRouter: URLRequestConvertible{
    case find /// 내 위시리스트 목록 조회
    case append(foodID:Int) /// 내 위시리스트에 음식 추가
    case delete(id: Int) /// 내 위시리스트에서 음식 제거
    case likeOne(id: Int) /// 음식에 좋아요 +1
    case topThree /// 다른 임산부들이 위시리스트에 많이 추가한 항목 top3
    static let baseURL = URL(string: API_Key.baseURL + "/wishlist")
    var endPath:String{
        switch self{
        case .append: ""
        case .delete(id: let id): "/\(id)"
        case .find: ""
        case .likeOne(id: let id): "/\(id)"
        case .topThree: ""
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .append: .post
        case .delete: .delete
        case .find: .get
        case .likeOne: .patch
        case .topThree: .get
        }
    }
    var headers:HTTPHeaders{
        var headers = HTTPHeaders()
        switch self{
        case .append: headers["Content-Type"] = "application/json;charset=UTF-8"
        case .delete: break
        case .find: break
        case .likeOne: break
        case .topThree: break
        }
        headers["accept"] = "application/json;charset=UTF-8"
        return headers
    }
    var params: Parameters{
        var params: Parameters = .init()
        switch self{
        case .append(let foodID):
            params["foodId"] = "\(foodID)"
        default: break
        }
        return params
    }
    func asURLRequest() throws -> URLRequest {
        guard var url = Self.baseURL else { return URLRequest(url: URL(string: "www.naver.com")!) }
        if endPath != "" { url = url.appendingPathComponent(endPath) }
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
