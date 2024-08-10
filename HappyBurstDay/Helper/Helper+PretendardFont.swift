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
        static let headline2: Font = .custom("SUIT-ExtraBold", size: 26)
    }
    
    enum Midline {
        static let Midline: Font = .custom("SUIT-ExtraBold", size: 24)
    }
    
    enum Title {
        static let title1: Font = .custom("Pretendard-Bold", size: 24)
        static let title2: Font = .custom("Pretendard-Bold", size: 20)
        static let title3: Font = .custom("Pretendard-Bold", size: 18)
        static let title4: Font = .custom("SUIT-Bold", size: 16)
    }
    
    enum Body {
        static let body1: Font = .custom("Pretendard-Medium", size: 16)
        static let body2: Font = .custom("Pretendard-Medium", size: 14)
        static let body3: Font = .custom("SUIT-Light", size: 16)
    }
    
    enum Alert {
        static let alert: Font = .custom("Pretendard-Regular", size: 12)
        static let alert2: Font = .custom("SUIT-Light", size: 12)
    }
}
