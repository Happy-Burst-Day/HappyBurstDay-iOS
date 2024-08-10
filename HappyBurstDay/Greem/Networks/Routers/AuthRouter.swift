//
//  SignRouters.swift
//  HappyBurstDay
//
//  Created by Greem on 8/10/24.
//

import Foundation
import Alamofire


enum AuthRouter: URLRequestConvertible{
   case signUp,signIn
    
    
    func asURLRequest() throws -> URLRequest {
        
    }
}
