//
//  Helper+PretendardFont.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/10/24.
//

import SwiftUI

extension Font {
    
    enum Headline {
        static let headline: Font = .custom("Pretendard-Bold", size: 25)
    }
    
    enum Title {
        static let title1: Font = .custom("Pretendard-Bold", size: 24)
        static let title2: Font = .custom("Pretendard-Bold", size: 20)
        static let title3: Font = .custom("Pretendard-Bold", size: 18)
    }
    
    enum Body {
        static let body1: Font = .custom("Pretendard-Medium", size: 16)
        static let body2: Font = .custom("Pretendard-Medium", size: 14)
    }
    
    enum Alert {
        static let alert: Font = .custom("Pretendard-Regular", size: 12)
    }
    
    static func pretendard(weight: PretendardFontWeight,size: CGFloat) -> Font{
        .custom("Pretendard-\(weight.name)", size: size)
    }
    enum PretendardFontWeight:String {
        case bold, medium,regular
        var name:String{
            switch self{
            case .bold: "Bold"
            case .medium: "Medium"
            case .regular: "Regular"
            }
        }
    }
}
