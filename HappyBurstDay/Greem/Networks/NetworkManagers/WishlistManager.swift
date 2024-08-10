//
//  WishlistManager.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import Foundation
import Alamofire

extension NetworkManager{
    final class WishlistManager{
        weak var delegate:NetworkManagerDelegate!
        init(delegate: NetworkManagerDelegate){
            self.delegate = delegate
        }
        /// 내 위시리스트 목록 조회
        func findList() async throws -> ResponseWishlistDto{
            let router = WishRouter.find
            return try await withCheckedThrowingContinuation {[weak self] continuation in
                guard let self else {return}
                AF.request(router, interceptor: delegate.baseInterceptor)
                    .validate(statusCode: 200..<300)
                    .response { res in
                    switch res.result{
                    case .success(let data):
                        guard let data else {
                            continuation.resume(throwing: NetworkErrors.loginAccessError).self
                            return
                        }
                        do{
                            let responseWishListDto = try JSONDecoder().decode(ResponseWishlistDto.self, from: data)
                            continuation.resume(returning: responseWishListDto)
                        }catch{
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
        /// 내 위시리스트에 음식 추가
        func appendItem(id: Int) async throws -> WishlistItemDto{
            let router = WishRouter.append(foodID: id)
            return try await withCheckedThrowingContinuation { continuation in
                AF.request(router,interceptor: delegate.baseInterceptor)
                    .validate(statusCode: 200..<300)
                    .response { res in
                    switch res.result{
                    case .success(let data):
                        guard let data else { 
                            continuation.resume(throwing: NetworkErrors.loginAccessError)
                            return
                        }
                        do{
                            let itemDto = try JSONDecoder().decode(WishlistItemDto.self, from: data)
                            continuation.resume(returning: itemDto)
                        }catch{
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
        
        /// 내 위시리스트에서 음식 제거
        func deleteItem(id:Int) async throws{
            let router = WishRouter.delete(id: id)
            return try await withCheckedThrowingContinuation {[weak self] continuation in
                guard let self else {return}
                AF.request(router, interceptor: delegate.baseInterceptor)
                    .validate(statusCode: 200..<300)
                    .response { res in
                    switch res.result{
                    case .success(let data):
                        if data == nil{
                            continuation.resume(returning: ())
                        }else {
                            continuation.resume(throwing: NetworkErrors.reissueError)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
        
        /// 음식에 좋아요 +1
        func likeOne(id:Int) async throws -> WishlistItemDto{
            let router = WishRouter.likeOne(id: id)
            return try await withCheckedThrowingContinuation { contiuation in
                AF.request(router, interceptor: delegate.baseInterceptor)
                    .validate(statusCode: 200..<300)
                    .response {[weak self] res in
                    guard let self else { return }
                    switch res.result{
                    case .success(let data):
                        guard let data else { contiuation.resume(throwing: NetworkErrors.loginAccessError); return;}
                        do{
                            let wishListItemDto = try JSONDecoder().decode(WishlistItemDto.self, from: data)
                            contiuation.resume(returning: wishListItemDto)
                        }catch{
                            contiuation.resume(throwing: NetworkErrors.loginAccessError)
                        }
                    case .failure(let error):
                        contiuation.resume(throwing: error)
                    }
                }
            }
            
        }
        
        /// 다른 임산부들이 위시리스트에 많이 추가한 항목 top3
        func topTree() async throws -> ResponseWishlistRankingDto{
            let router = WishRouter.topThree
            return try await withCheckedThrowingContinuation {[weak self] contination in
                guard let self else {return}
                AF.request(router,interceptor: delegate.baseInterceptor)
                    .validate(statusCode: 200..<300)
                    .response { res in
                    switch res.result{
                    case .success(let data):
                        guard let data else { contination.resume(throwing: NetworkErrors.reissueError); return }
                        do{
                            let topThreeDto = try JSONDecoder().decode(ResponseWishlistRankingDto.self, from: data)
                            contination.resume(returning: topThreeDto)
                        }catch{
                            contination.resume(throwing: NetworkErrors.signUpAccessError)
                        }
                    case .failure(let error):
                        contination.resume(throwing: error)
                    }
                }
            }
        }
    }
}
