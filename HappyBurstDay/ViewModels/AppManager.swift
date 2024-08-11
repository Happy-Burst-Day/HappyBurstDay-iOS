//
//  AppManager.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import Foundation
import Combine

final class  AppManager{
    let loginPassthroughSubject = PassthroughSubject<Bool,Never>()
    static let shard = AppManager()
    private init(){
        DispatchQueue.main.asyncAfter(deadline: .now()){
            if let expiration = Defaults.shared.expiration, expiration > Date(){
                self.loginPassthroughSubject.send(true)
            }else{
                self.loginPassthroughSubject.send(false)
            }
        }
    }
}
