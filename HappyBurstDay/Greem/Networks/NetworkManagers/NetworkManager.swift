//
//  NetworkManager.swift
//  HappyBurstDay
//
//  Created by Greem on 8/10/24.
//

import Foundation
import Alamofire
protocol NetworkManagerDelegate:NSObject{
    var baseInterceptor: AuthenticatorInterceptor { get set}
}
final class NetworkManager:NSObject,NetworkManagerDelegate{
    static let shared = NetworkManager()
    static let accessExpireSeconds:Double = 60 * 60
    var baseInterceptor:AuthenticatorInterceptor = AuthenticatorInterceptor()
    lazy var auth = AuthManager(delegate: self)
    override init() { super.init() }
}

