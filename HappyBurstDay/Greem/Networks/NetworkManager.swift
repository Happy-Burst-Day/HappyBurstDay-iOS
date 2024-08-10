//
//  NetworkManager.swift
//  HappyBurstDay
//
//  Created by Greem on 8/10/24.
//

import Foundation
import Alamofire
protocol NetworkManagerDelegate:NSObject{ }
final class NetworkManager:NSObject,NetworkManagerDelegate{
    static let shared = NetworkManager()
    lazy var auth = AuthManager(delegate: self)
    override init() { super.init() }
}

