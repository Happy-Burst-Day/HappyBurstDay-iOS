//
//  SearchModel.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/11/24.
//

import Foundation

struct SearchModel: Identifiable {
    let id = UUID()
    
    let info: Int
    let food: String
    let calorie: String
    let foodInfo: String
}
