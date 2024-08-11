//
//  WishListModel.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/11/24.
//

import Foundation

struct WishListModel: Identifiable {
    let id = UUID()
    
    let name: String
    let safeType: String
    let calorie: String
    let tages: [String]
    let likes: Int
}
