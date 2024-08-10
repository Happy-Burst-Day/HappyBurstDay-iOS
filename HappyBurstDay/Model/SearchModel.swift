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
    SearchModel(info: 1, food: "사과", calorie: "52", foodInfo: 2),
    SearchModel(info: 2, food: "햄버거", calorie: "250", foodInfo: 1),
    SearchModel(info: 3, food: "닭가슴살", calorie: "165", foodInfo: 2),
    SearchModel(info: 1, food: "브로콜리", calorie: "34", foodInfo: 3),
    SearchModel(info: 2, food: "초콜릿", calorie: "546", foodInfo: 1),
    SearchModel(info: 3, food: "연어", calorie: "206", foodInfo: 3),
    SearchModel(info: 1, food: "아몬드", calorie: "575", foodInfo: 2),
    SearchModel(info: 2, food: "감자튀김", calorie: "365", foodInfo: 1),
    SearchModel(info: 3, food: "계란", calorie: "155", foodInfo: 3)
]
