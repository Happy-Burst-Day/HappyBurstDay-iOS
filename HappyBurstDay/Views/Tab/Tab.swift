//
//  Tab.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/11/24.
//

enum Tab: Int, Identifiable, Hashable, Comparable, TabTitleConvertible {
  case one
  case two
  
  var title: String {
    switch self {
    case .one: return "WishList"
    case .two: return "MyBaby"
    }
  }
  var id: Int {
    rawValue
  }
  
  static func < (lhs: Self, rhs: Self) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}
