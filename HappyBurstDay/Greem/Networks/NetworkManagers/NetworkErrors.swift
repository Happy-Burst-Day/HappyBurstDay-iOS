//
//  NetworkErrors.swift
//  HappyBurstDay
//
//  Created by Greem on 8/10/24.
//

import Foundation

enum NetworkErrors:Error{
    /// 로그인 접근에 실패했습니다.
    case loginAccessError
    /// 회원가입 접근에 실패했습니다.
    case signUpAccessError
    case reissueError
}
