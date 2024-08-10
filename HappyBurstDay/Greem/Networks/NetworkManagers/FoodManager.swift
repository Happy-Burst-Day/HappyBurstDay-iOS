//
//  FoodManager.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import Foundation
import Alamofire

extension NetworkManager{
    final class FoodManager{
        weak var delegate:NetworkManagerDelegate!
        init(delegate: NetworkManagerDelegate){
            self.delegate = delegate
        }
        func search(keyword: String) async throws -> [FoodDto]{
            let parameters = ["keyword":keyword]
            return try await withCheckedThrowingContinuation { continuation in
                AF.request(API_Key.baseURL+"/food",method: .get,parameters: parameters,
                           interceptor: delegate.baseInterceptor)
                .validate(statusCode: 200..<300)
                .response {[weak self] res in
                    switch res.result{
                    case .success(let data):
                        guard let data else {
                            continuation.resume(throwing: NetworkErrors.loginAccessError)
                            return
                        }
                        do{
                            let foods = try JSONDecoder().decode([FoodDto].self, from: data)
                            continuation.resume(returning: foods)
                        }catch{
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error): continuation.resume(throwing: error)
                    }
                }
            }
            
            
        }
    }
}
