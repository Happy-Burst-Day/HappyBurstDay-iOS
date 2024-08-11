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
    let foodInfo: Int
}

let dummyData: [SearchModel] = [
    SearchModel(info: 1, food: "apple", calorie: "52", foodInfo: 2),
    SearchModel(info: 2, food: "hamburger", calorie: "250", foodInfo: 1),
    SearchModel(info: 3, food: "chicken breast", calorie: "165", foodInfo: 2),
    SearchModel(info: 1, food: "broccoli", calorie: "34", foodInfo: 3),
    SearchModel(info: 2, food: "chocoloate", calorie: "546", foodInfo: 1),
    SearchModel(info: 3, food: "salmon", calorie: "206", foodInfo: 3),
    SearchModel(info: 1, food: "almond", calorie: "575", foodInfo: 2),
    SearchModel(info: 2, food: "potato sticks", calorie: "365", foodInfo: 1),
    SearchModel(info: 3, food: "egg", calorie: "155", foodInfo: 3)
]
